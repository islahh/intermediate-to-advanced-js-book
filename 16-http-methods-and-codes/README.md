The HTTP protocol has a set of methods we can use when making requests:

- GET
- POST
- PUT
- DELETE
- PATCH

Whnever we make a request, we specify what type of request we are making by using one of the methods above. You can think of it as a type of verb.

# Clarifying what API is

API stands for Application Programming Interface. It simply refers to the surface of a system that you can interact with.

We often refer to Backend APIs when talking about APIs. These are exposed to the frontend as URLs. We can make requests and specify what we want to happen.

If our backend route has an endpoint pointing to `/api/todos`, we can use this endpoint to do a handful of things.

# Continuing

If we make a request to `https://foo.com`, we are telling the server at `foo.com` that we want something to happen. It could be we want to get some data. It could also be we want to tell the server to create some data and store it in the database.

The HTTP methods help us tell the server what we want to do. Making the same request with a different method will result in a different outcome.

For example, if we make a GET request to `https://foo.com`, the server will respond with some data. If we make a POST request to `https://foo.com`, the server will create a new record in the database.

# GET

`GET /api/todos`

GET is the default method. When you make GET requests, you are asking the server to give you some data. You're retrieving data.

# POST

`POST /api/todos`

POST is used to create new data. In this case, a new todo item.

# PUT vs PATCH

`PUT /api/todos/1` and `PATCH /api/todos/1` are both used to update an existing todo item with the ID of 1, but they differ in how they update the resource.

## PUT

- PUT is used when you want to **replace** the entire resource.
- You must send the complete updated object in the request body.
- If any properties are missing from the request, they will be removed or set to their default values on the server.

## PATCH

- PATCH is used when you want to **partially update** a resource.
- You only send the properties that you want to update in the request body.
- Any properties not included in the request will remain unchanged on the server.

PATCH is more efficient than PUT when you only need to update a few properties, especially for larger objects. Imagine updating a user object with many fields (e.g., name, email, address, phone). With PUT, you would have to send the entire object, even if you're only changing the email. With PATCH, you can send just the email property, reducing the network payload size and processing overhead.

# DELETE

`DELETE /api/todos/1`

DELETE is used to delete data. In this case, deleting a todo item with the id 1.

# Technical differences

When you send a request with an HTTP method, you tell the backend what to do. The backend however, is the one "actually" doing something.

These requests exist so that we can tell the backend different things to do for the same endpoint.

One important thing I have not mentioned yet: The body parameter.

If we take a look at `POST /api/todos`, how does the backend know what todo item to create?

Because at the frontend is where the user entered the todo item into the input.

```
POST /api/todos
body: {
  "title": "New todo item"
  "description": "This is a new todo item"
  "completed": false
}
```

The API will create a new todo item with the title, description, and completed set to false.

The API will also return the new todo item. Which is useful because we can e.g. inform the user that the todo item has been created.

# Status Codes

When we get a response from the server, we get a status code. This code tells us what happened.

Some common ones:

- 200: OK
- 201: Created
- 400: Bad Request
- 401: Unauthorized
- 404: Not Found
- 500: Internal Server Error

```js
async function makeRequest() {
  const response = await fetch("/api/some-endpoint");

  console.log(response.status); // 200
}
```

We haven't dove into fetch yet, which I assume you've touched.

But we're gonna dive into some good stuff and you'll learn more than you think.

Generally, status codes have three categories:

100-199 — Informational responses
200-299 — Successful responses
300-399 — The request has been redirected
400-499 — The client made a mistake
500-599 — Something's wrong with the server
