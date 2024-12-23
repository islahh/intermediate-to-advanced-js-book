# Introduction

We're now gonna dive into fetch.

You've probably used fetch where you needed to make a request to the server. Likely to get some data you can display on the screen.

Let's look at some code you may have written:

```js
fetch("/api/todos")
  .then((response) => response.json())
  .then((data) => console.log(data))
  .catch((error) => console.error("Error:", error));
```

```js
try {
  const response = await fetch("/api/todos");
  const data = await response.json();
  console.log(data);
} catch (error) {
  console.error("Error:", error);
}
```

You may understand that fetch is a function that takes a URL and makes a request to the server. And then gives you something back.

However, let's dive into really understanding what's happening throughout the entire flow, which includes how things work in the browser.

We're gonna start off by going through this example with the GET request (since it's the default method).

Once we're through this, I wanna take a look:

- POST request
- Body parameter
- Working with FormData

# Fetch at a high level

Fetch takes a URL and make a request to that URL.

By nature, fetch is asynchronous. When we make a request and communicate with an external party, we don't know how long it will take to get a response back.

This isn't an operation that we want blocking the callstack.

It then gives you a Promise that resolves to a Response.