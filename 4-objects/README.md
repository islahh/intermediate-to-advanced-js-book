# This module

In this module, I'm not here to introduce you to objects. But I want to recap some of the key points when it comes to objects in JavaScript.

# Creating and accessing objects

Objects in JavaScript are key-value pairs. You can create an object using curly braces `{}`. Here's an example:

```js
const person = {
  name: "Lydia",
  age: 21,
};
```

To access values in an object, you can use either dot notation or bracket notation:

```js
console.log(person.name); // Lydia
console.log(person["age"]); // 21
```

# Destructuring

Destructuring allows you to extract multiple properties from an object and store them in variables. Here's an example:

```js
const person = {
  name: "Lydia",
  age: 21,
};

const { name, age } = person;
console.log(name, age); // Lydia 21
console.log(person); // { name: 'Lydia', age: 21 }
```

It's important to note:

- you can destructure properties in any order
- names of the variables need to match the property names

If you wanna rename the variables, you can do so by using the following syntax:

```js
const person = {
  name: "Lydia",
  age: 21,
};

const { name: personName, age: personAge } = person;
console.log(personName, personAge); // Lydia 21
```

# Objects are mutable and passed by reference

```js
const person = {
  name: "Lydia",
  age: 21,
};

const person2 = person;

console.log(person2); // { name: 'Lydia', age: 21 }

person2.name = "Sarah";

console.log(person); // { name: 'Sarah', age: 21 }
```

As mentioned previously in the course, objects are mutatable and passed by reference. Which means that when you change a property in an object, it will also change the original object. Because they both point to the same reference in memory. Primitive types are immutable, so changing them won't affect the original value. Objects aren't newly created when changed, but rather modified in place.
