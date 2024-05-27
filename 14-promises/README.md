# What is a promise?

A Promise is an object that represents the eventual completion or failure of an asynchronous operation and its resulting value.

Async operations are operations that take an unknown amount of time to complete. For example, reading a file from disk, making a network request, or querying a database.

It's often an operation where you don't know when it will complete, or how long it will take.

Sync operations are operations that complete immediately. For example, adding two numbers together.

It's not always the case, but async operations are often doing side effects, meaning interacting with the outside world. Which is also why it's not known when it will complete.

In the simplest terms, a promise is like saying "I promise to give you a result later". The result can be a success (resolved value) or a failure (error).

```js
// this function runs immediately
let promise = new Promise(function(resolve, reject) {
  // do something async, then...
  if (/* async operation succeeded */) {
    resolve("Success!");
  } else {
    reject(Error("Failure!"));
  }
});

// one way
promise.then((value) => console.log(value), (error) => console.log(error));

// another way
promise.then((value) => console.log(value)).catch((error) => console.log(error));
```

# Before promises

Before promises, asynchronous code was handled with callbacks. Callbacks often led to deeply nested code, known as "callback hell":

```js
doSomething(function (result) {
  doSomethingElse(
    result,
    function (newResult) {
      doThirdThing(
        newResult,
        function (finalResult) {
          console.log("Got the final result: " + finalResult);
        },
        failureCallback
      );
    },
    failureCallback
  );
}, failureCallback);
```

How this code works: `doSomething` starts an async operation, and when it's done, it calls its callback function. That callback function starts the next async operation, and when it's done, it calls its callback function. This can go on indefinitely.

As you can already tell, the code is hard to read and maintain. It looks awful. And by the way, even till today, JavaScript is evolving as a programming language. That's why it's always improving. So, it's not a developer's fault if they wrote such code in the past.

# Promises

Promises provide a cleaner way to write code.

A promise can be in one of three states:

- Pending
- Fulfilled
- Rejected

You handle a promise's state changes using the `then` method:

```js
promise.then(onFulfilled, onRejected);
```

`.catch` is actually a shorthand for `.then(null, onRejected)`:

```js
promise.catch(onRejected);
```

As you can see, `.then` allows you to chain multiple promises together. When once promise is resolved, the next one is called with the resolved value. Resolved value meaning the value the promise returned.

# Chain promises and end with a catch

You can also chain promises together and end with a catch:

```js
promise
  .then((value) => {
    console.log(value);
    return value + 1;
  })
  .then((value) => {
    console.log(value);
    return value + 1;
  })
  .then((value) => {
    console.log(value);
    return value + 1;
  })
  .catch((error) => {
    console.log(error);
  });
```

# The introduction of Promises

When promises were introduced, they were designed to solve the problem of callback hell. They were designed to make async code easier to write, read and reason about.

Promises are different from other Web APIs like `setTimeout`. The intention with promises is async code. Code that's unpredictable and can take an unknown amount of time to complete.

Because of this, a new queue was introduced in the event loop called the "microtask queue". This queue is where promises are placed before entering the call stack.

This queue has higher priority than the callback queue. This means that promises are executed before callbacks such as the callback of `setTimeout`.

The reason for that is because promises serve a different purposes. And having a predictable order of execution is important. As opposed to things happening randomly.

# The flow of a promise

1. `new Promise` is called. Runs instantly. This happens on the callstack, synchronously.
2. `new Promise` is popped off the stack and the async operation is sent to the Web API environment where it runs.
3. When the async operation is done, the promise is either resolved or rejected.
4. A microtask is created and placed in the microtask queue.
5. This microtask contains the code that's inside the `then` method.
6. Remember, `catch` is just a shorthand for `then(null, onRejected)`.
7. If rejected, we'll still run `then` under the hood, but with the `onRejected` callback.
8. The microtask in the microtask queue contains the code that's inside the `then` method.
9. When the call stack is empty, the event loop first checks the microtask queue.
10. Since we have a microtask in the queue, it's placed on the call stack and executed.
11. You can think of the microtask queue calling `task.execute()` on the callstack.

Does the callback run immediately? No. `.then` under the hood wraps the return value in a new promise. This new promise will create a new microtask in the microtask queue.

This may seem unnecessary. Why would we have two microtasks for a "single" promise?

Well, it's because the design of promises is that they're chainable. You can chain multiple promises together. And each promise in the chain is a new promise.

As mentioned previously, when promises were designed, it was important that things are consistent and follow a predictable order of execution.

Let's look at some code, to understand this better:

```js
const promiseOne = new Promise((resolve, reject) => {
  console.log("promiseOne");
  resolve(1);
});

const promiseTwo = new Promise((resolve, reject) => {
  console.log("promiseTwo");
  resolve(2);
});

promiseTwo
  .then((value) => {
    console.log(value);
    return value + 1;
  })
  .then((value) => {
    console.log(value);
    return value + 1;
  });

promiseOne.then((value) => {
  console.log(value);
  return value + 1;
});
```

Here we have in total 5 microtasks.

The first two being the `new Promise` calls.

We then chain two promises on `promiseTwo`.

On `promiseOne`, we chain one promise.

They all resolved in the order they were created. I'm referring to the microtasks created here.

The last promise to resolve will be `promiseOne`'s `then` method.

# The promise object

One thing I've left out of the equation is the promise object.

The promise object itself is an actual object that's stored in the memory heap.

It's something I wanted to clarify, to avoid any confusion.

# Event loop pseudo code

```js
// Event loop
while (true) {
  // Execute synchronous code

  // Check and execute microtasks
  while (microtaskQueue.hasTasks()) {
    const task = microtaskQueue.dequeue();
    task.execute(); // Execute promise handlers
  }

  // Check and execute regular tasks
  while (callbackQueue.hasTasks()) {
    const task = callbackQueue.dequeue();
    task.execute(); // Execute callback handlers
  }
}
```

# A complicated example with promises and setTimeout

```js
const promise = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve("First promise done!");
  }, 1000);
});

const promise2 = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve("Second promise done!");
  }, 500);
});

promise.then((value) => {
  setTimeout(() => {
    console.log("Third promise done! I am called by the first promise.");
  }, 1000);
});

promise2.then((value) => {
  setTimeout(() => {
    console.log("Fourth promise done! I am called by the second promise.");
  }, 500);
});
```
