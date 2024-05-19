# Loops and Iteration

I'm sure you've seen a loop before:

```js
for (let i = 0; i < 5; i++) {
  console.log(i);
}
```

Here we're using a `for` loop to log the numbers 0 through 4 to the console.

This shouldn't be new to you.

I wanna dive into two things here:

- for of loops
- for in loops

# Iterable Objects

First, let's talk about iterable objects. It's gonna set the foundation for our knowledge to minimize confusion. As you remember, for example, arrays are objects in JavaScript.

An iterable object is an object that implements the iterable protocol, which means it has a `Symbol.iterator` method. This includes arrays, strings, maps, sets, and more. To simplify, if you can loop over something in JavaScript, it's an iterable object.

If this iterable protocol didn't exist, we wouldn't just be able to loop over objects, but other features in JavaScript wouldn't work as well, such as destructuring, the spread operator, and more.

# For in loops

For in loops are used to loop over the keys of an object.

```js
const person = {
  name: "John",
  age: 30,
  city: "New York",
};

for (const key in person) {
  console.log(key, person[key]);
}
```

This should be quite straightforward. We're looping over the keys of the `person` object and logging the key and value to the console.

# For of loops

For of loops is a modern way to loop over an iterable object.

```js
const people = ["John", "Jane", "Joe"];

for (const person of people) {
  console.log(person);
}
```

What if people was an array of objects?

```js
const people = [
  { name: "John", age: 30 },
  { name: "Jane", age: 25 },
  { name: "Joe", age: 35 },
];

for (const person of people) {
  console.log(person.name, person.age);
}
```

Destructuring here is also possible:

```js
for (const { name, age } of people) {
  console.log(name, age);
}
```

# Looping over a string

You can also loop over a string with a for of loop:

```js
const name = "John";

for (const char of name) {
  console.log(char);
}
```

This is gonna log each character of the string to the console.

# Loop over objects

What if you want to loop over an object?

You first need to decide what you want to loop over:

- Values -> `Object.values` gives you an array of values.
- Keys -> `Object.keys` gives you an array of keys.
- Entries -> `Object.entries` gives you an array of key-value pairs, each as an array.

You need to turn the object into an iterable object first. We know arrays are iterable objects, so we can use `Object.values`, `Object.keys`, or `Object.entries` to turn the object into an array.

```js
const person = {
  name: "John",
  age: 30,
  city: "New York",
};

for (const value of Object.values(person)) {
  console.log(value);
}

for (const key of Object.keys(person)) {
  console.log(key);
}

for (const [key, value] of Object.entries(person)) {
  console.log(key, value);
}
```

The examples should be quite clear already. The third one can be a bit confusing but we're destructuring the array of key-value pairs. The first element of the array is the key, and the second element is the value. If we didn't destructure, we would have to access the key and value by indexing: `console.log(pair[0], pair[1])`.
