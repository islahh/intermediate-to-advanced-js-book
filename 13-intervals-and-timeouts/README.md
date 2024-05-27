# setTimeout

We already went over how `setTimeout` works, but let's recap how it works.

1. `setTimeout` is added to the call stack.
2. The `setTimeout` function is executed, which schedules the callback to be run after the specified delay (in this case, 0 milliseconds). The callback function itself is not executed at this point.
3. `setTimeout` is removed from the call stack.
4. The callback function is sent to the Web APIs environment to be handled by the browser's timer mechanism.
5. `console.log("I am not a callback")` is added to the call stack and executed.
6. `console.log("I am not a callback")` is removed from the call stack.
7. After the specified delay (which is practically immediate in this case), the Web APIs environment sends the callback function to the Callback Queue.
8. The Event Loop checks if the call stack is empty. If it is, it takes the first callback function from the Callback Queue and pushes it onto the call stack.
9. The callback function `() => { console.log("I am a callback"); }` is added to the call stack.
10. The callback function is executed, and `console.log("I am a callback")` is added to the call stack.
11. `console.log("I am a callback")` is executed and removed from the call stack.
12. The callback function is removed from the call stack.

So, when `setTimeout` is executed, it doesn't directly add the `console.log` to the call stack. Instead, it schedules the callback function to be executed later by the Web APIs environment and the Event Loop mechanism.

The callback queue is also referred to as the macrotask queue.

## Timer ID

`setTimeout` returns a timer ID, which can be used to cancel the scheduled callback before it is executed. The `clearTimeout` function is used to cancel a scheduled `setTimeout` callback.

Now, it's important to clarify: The Web API environment keeps track of all active timers. When a timer is set, the Web API environment starts counting down. When the timer reaches zero, the callback is sent to the callback queue.

```js
const id = setTimeout(() => {
  console.log("I am a callback");
}, 1000);

clearTimeout(id);
```

Here, we set a timer to run after 1 second. However, we immediately cancel the timer using `clearTimeout`. The callback will never be executed.

If the timer is cleared before it reaches zero, the callback is never sent to the callback queue. However, if the timer has already reached zero and the callback is in the callback queue, it will be executed. So if you clear a timer after the callback function is inside the callback queue, it won't be removed.

# setInterval

The main difference here compared to `setTimeout` is that the Web APIs environment will keep sending the callback to the callback queue at the specified interval.

When `clearInterval` is called with a valid interval ID, it completely stops the interval and prevents any further queuing of the callback function. No new intervals will be queued after `clearInterval` is called.

To start the interval again, you need to call `setInterval` with the same callback function.

# interesting setTimeout and setInterval example

```js
let intervalId;

function startInterval() {
  intervalId = setInterval(function () {
    console.log("Interval callback");
  }, 1000);
}

function skipNextInterval() {
  clearInterval(intervalId);
  setTimeout(function () {
    startInterval();
  }, 2000);
}

startInterval();

// Skip the next interval after 3 seconds
setTimeout(skipNextInterval, 3000);
```

This is a quite interesting example. We start an interval that logs "Interval callback" every second. After 3 seconds, we skip the next interval by clearing the interval and starting a new interval after 2 seconds.

# Debouncing

```js
function debounce(callback, delay) {
  let timeoutId;

  return function (...args) {
    clearTimeout(timeoutId);

    timeoutId = setTimeout(() => {
      callback.apply(this, args);
    }, delay);
  };
}
```

```js
const input = document.getElementById("myInput");

function handleInput(event) {
  console.log("Input value:", event.target.value);
  // Perform any desired actions with the input value
}

const debouncedHandleInput = debounce(handleInput, 300);

input.addEventListener("input", debouncedHandleInput);
```

Every time the user types in the input field, the `handleInput` function is called. However, the `debounce` function ensures that the `handleInput` function is only called after the user has stopped typing for 300 milliseconds. Otherwise it would be inefficient to call the `handleInput` function on every keystroke. That's why we clear the timeout every time the user types a new character.

## Why do we need the `apply` method?

The `apply` method is used to properly set the `this` context when calling the `callback` function. If we don't use `apply`, the `this` context will be lost when calling the `callback` function.

Let's look at an example where we're not using `apply` in the `debounce` function:

```js
const obj = {
  name: "John",
  greet: function () {
    console.log(`Hello, ${this.name}!`);
  },
};

const debouncedGreet = debounce(obj.greet, 1000);

// Calling the debounced function
debouncedGreet(); // Output: "Hello, undefined!"
```

When you pass a method as a callback function, the `this` context is lost because the method is invoked as a standalone function, not as a method of the object. By using the `apply` method, we can ensure that the `this` context is preserved when calling the `callback` function.

When we first call `debounce`, this creates a new execution context. It also returns a new function. When calling this new function, it will execute the inner function, which is the callback function passed to `debounce`.

However, the inner function's this keyword is not automatically bound to the same value as the outer function's this. In a new execution context, this will either default to the global object (in non-strict mode) or be undefined (in strict mode).

# Throttling

Throttling is similar to debouncing. It's when you want to ensure that a function is called only once in a specified amount of time.

For exaple, let's say we have a resizing event happening:

```js
window.addEventListener("resize", () => {
  console.log("Window resized");
});
```

This will log "Window resized" every time the window is resized. However, if the user resizes the window multiple times within a short period, this can lead to performance issues.

We also don't need to run the callback function every time the user resizes the window. Instead, we can run the callback function at most once every 300 milliseconds.

We need to implement a function where:

- We keep track of the delay.
- We keep track of the last time the callback was called.
- Every time the callback is called, we check if the delay has passed since the last time the callback was called. If it has, we call the callback function.
- This check can be achieved by using the `Date.now()` method to get the current timestamp. We then subtract the last timestamp from the current timestamp to get the time that has passed since the last call.
- If the time that has passed is greater than the delay, we call the callback function and update the last timestamp.

```js
function throttle(fn, delay) {
  let lastTimeInMs = 0;
  return function (...args) {
    const currentTimeInMs = new Date().getTime();

    const timeSinceLastCall = currentTimeInMs - lastTimeInMs;

    if (timeSinceLastCall >= delay) {
      lastTimeInMs = currentTimeInMs;
      fn.apply(this, args);
    }
  };
}

// Example usage
window.addEventListener(
  "resize",
  throttle(() => {
    console.log("Resize event triggered");
  }, 1000)
);
```

We still need to bind the `this` context to the callback function using the `apply` method, as we did in the debounce function. The reason is the same: when calling the callback function, we want to ensure that the `this` context is preserved. If we don't use `apply`, the `this` context will be lost when calling the callback function.

An example to yet again illustrate the importance of the `apply` method:

```js
const obj = {
  name: "John",
  greet: function () {
    console.log(`Hello, ${this.name}!`);
  },
};

const throttledGreet = throttle(obj.greet, 1000);

// Calling the throttled function
throttledGreet(); // Output: "Hello, John!"
```
