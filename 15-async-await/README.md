# Problems with native promises

Let's look at some to understand the need for async/await in JavaScript.

```js
const promiseOne = new Promise((resolve, reject) => {
  // A promise that runs
  const result = func();

  if (result) {
    resolve(result);
  } else {
    reject("Error");
  }
});

let result;

promiseOne
  .then((resultFromPromiseOne) => {
    result = resultFromPromiseOne;
  })
  .catch((error) => {
    console.log(error);
  });

const transformedResult = transform(result);
```

This is just to demonstrate some basic code. But with this very little code, we aready have a problem.

The first problem is that the `transform` function will run before the promise is resolved. We're essentially passing undefined to the `transform` function.

The second problem is that we have to keep chaining promises to get the result we want. This is a basic example. Imagine in a real codebase.

How can we "wait" for the promise to resolve before running the `transform` function?

In our example we'd have to do something like this:

```js
promiseOne
  .then((resultFromPromiseOne) => {
    const transformedResult = transform(resultFromPromiseOne);
    // more code
  })
  .catch((error) => {
    console.log(error);
  });
```

The issue now is that we have to keep chaining promises. This doesn't solve the initial callback hell problem. We now have promises hell. Our code starts to look like a pyramid from the very root of the codebase.

# Async/Await to the rescue

With async/await, we can write the same code like this:

```js
async function PromiseOne() {
  try {
    const result = await func();
    return result;
  } catch (error) {
    console.log(error);
  }
}

const result = await PromiseOne();

const transformedResult = transform(result);
```

`async` is a keyword that tells JavaScript that the function is asynchronous. It's gonna automatically return a promise. `await` doesn't just tell JavaScript to wait for the promise to resolve. It also waits for the microtask to have been executed and unwraps the value from the promise.

This is much cleaner and easier to read/write.

This is the default way we should write asynchronous code in JavaScript.

# Running promises in parallel

```js
const urlsToFetch = [
  "https://jsonplaceholder.typicode.com/posts/1",
  "https://jsonplaceholder.typicode.com/posts/2",
  "https://jsonplaceholder.typicode.com/posts/3",
];

const result = [];

for (const url of urlsToFetch) {
  try {
    const post = await fetch(url);
    result.push(post);
  } catch (error) {
    console.log(error);
  }
}
```

Do you see issues with this code?

The issue is that we're running the promises sequentially. We're waiting for the first promise to resolve before running the next one.

It would've been better if we could run the promises in parallel.

Now we literally have to wait for the first promise to resolve and execute before the loop can continue.

It's because we're using `await` in the loop.

# Promise.all

To run promises in parallel, we can use `Promise.all`.

```js
const promisesToRun = [];

for (const url of urlsToFetch) {
  promisesToRun.push(fetch(url));
}

const result = await Promise.all(promisesToRun);
```

`fetch` returns a promise. When called, it triggers the promise and that's sent to the web API environment. The loop doesn't halt, it continues to the next iteration instantly.

We're not waiting for the promise to resolve before moving to the next iteration. When you "trigger" a promise this way, the async operation can run in parallel. This happens in the Web API environment.

`Promise.all` takes an array of promises and waits for all of them to resolve before returning the result. If one of them fails, the whole thing fails. We're gonna look at more Promise methods for dealing with promises in parallel.

# Promise.race, Promise.any, Promise.allSettled

`Promise.all` is not the only method for dealing with awaiting multiple promises.

To recap: Promise.all waits for all promises to resolve before returning the result. If one of them fails, the whole thing fails. So it's like saying, you all have to succeed or none of you succeed.

`Promise.race` is like saying, whoever finishes first, I'm gonna take that result. It doesn't matter if the other promises fail or not. If one of them finishes, that's the result. Whether error or success.

`Promise.allSettled` is like `Promise.all`, but you wait until all promises have settled. Settled means they can fail or succeed. Both outcomes are ok. It returns an array of objects, each representing the outcome of the promise. Each object in the array has a status property, which is either `"fulfilled"` or `"rejected"`, and a value property if the promise was fulfilled, or a reason property if the promise was rejected.

`Promise.any` is like `Promise.race`, but it only cares about the first promise to resolve. It needs one promise to become fulfilled. If all promises fail, it throws an error. But if some of the promises fail, it doesn't throw an error. It just returns the first promise to resolve.
