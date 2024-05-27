# The different types

We have different data types in JavaScript.

- **Primitive types**: `string`, `number`, `boolean`, `undefined`, `null`, `symbol`, and `bigint`.
- **Reference types**: `object`, `function`, and `array`.

# Primitive types

Primitive types are the most basic data types in JavaScript. They're immutable. This means that once a primitive value is created, it can't be changed. Don't confuse this with reassigning a variabe. Reassigning a variable is not the same as changing the value of a primitive type.

## Reassigning is fine

```javascript
// string example
let str = "hello";
str = "Hello"; // str -> "Hello"
```

In this example, we're reassigning the variable `str` to a new value. This is perfectly fine.

## Same values are same values in memory

```javascript
let str1 = "hello";
let str2 = "hello";
```

Here we have two variables `str1` and `str2` that have the same value. In JavaScript, if two primitive values are the same, they're equal. They're equal because under the hood in memory, both variables point to the same memory location.

Same strings aren't re-created in memory. They're stored in memory only once. JavaScript enginers use a technique called string interning to optimize memory usage. Interning is also used for numbers.

## Primitive types are immutable

```javascript
let str = "hello";
str[0] = "H"; // str -> "hello"
```

You can not change a string once it's created. In this example, we're trying to change the first character of the string `str` to "H". This won't work. The string `str` will remain the same. Primitive types are immutable.

# Reference types

Reference types are mutable. This means that you can change the value of a reference type. They're called reference types to highlight that they're stored as references in memory. Strings are too, but they're immutable and use the "interning" technique to not re-create same values in memory.

## Objects are newly created in memory

```javascript
let obj1 = { name: "John" };
let obj2 = { name: "John" };
```

Here, `obj1` and `obj2` are two different objects. They're stored in different memory locations. Even though they have the same properties and values, they're not equal.

## Mutating objects with the same reference

```javascript
let obj1 = { name: "John" };
let obj2 = obj1;
```

Here, `obj1` and `obj2` are the same object. By that, I mean both variables point to the same memory location. If you change the value of this location, it's reflected in both variables. This isn't really rocket science. They both point to the same value, and because no new object is created, changing the value of one changes the value of the other.

Or to be clear: The value they are pointing to.

```javascript
obj2.name = "Jane"; // obj1 -> { name: "Jane" }, obj2 -> { name: "Jane" }
```

To visualize how this would look in memory:

```
Memory location 1: { name: "John" }

obj1 -> Memory location 1
obj2 -> Memory location 1
```

With the update:

```
Memory location 1: { name: "Jane" }

obj1 -> Memory location 1
obj2 -> Memory location 1
```

We updated the value in memory location 1. It's only natural that both `obj1` and `obj2` reflect this change.

# Why 1 === 1 is true but {} === {} is false

By now, you should be able to understand why `1 === 1` is true but `{}` is false. It's all about where they point to in memory. When you compare two primitive values, you're comparing the two memory locations they point to. If they point to the same location, they're equal. If they don't, they're not.

Objects are always newly created in memory. A new object means a new memory location. This memory is where objects are created is called the heap.

# Checking for a type with `typeof` operator

`typeof` operator is used to check the type of a value. It returns a string that represents the type of the value.

```javascript
typeof "hello"; // "string"
typeof 42; // "number"
typeof true; // "boolean"
typeof undefined; // "undefined"
typeof null; // "object"
typeof {}; // "object"
typeof []; // "object"
typeof function () {}; // "function"
```

As you can see, yes, null and arrays are objects in JavaScript.

# Surprise: null and arrays are objects under the hood

Null and arrays are objects in JavaScript. In fact, functions are object too, even if `typeof` returns "function" for functions.

- Null
- Arrays
- Functions

These are all objects in JavaScript. Well, null not really.

Null to be clear was a mistake. That's a mistake in the JS programming language that can't be fixed because it would break the web. So, we're stuck with it.

As for arrays and functions, they're objects. That's how they're implemented under the hood. So that's correct.

If we look at functions, they're objects. But they have a special internal property called `[[Call]]` that makes them callable.

# `let` vs `const`: Understanding the difference

`let` and `const` are used to declare variables in JavaScript. The difference between them is that `let` allows you to reassign a variable, while `const` doesn't.

```javascript
const name = "John";
name = "Jane"; // TypeError: Assignment to constant variable.
```

You can't reassign a variable declared with `const`. This is because `const` is used to declare a variable that won't change. It's a constant.

```javascript
let name = "John";
name = "Jane"; // name -> "Jane"
```

With `let`, you can reassign a variable.

## const is a lie

Constants in JavaScript only prevent reassigning a variable. They don't prevent changing the value of a variable.

```javascript
const obj1 = { name: "John" };
obj1.name = "Jane"; // obj1 -> { name: "Jane" }
```

This is totally fine. In other programming languages with a strict typing system, this would throw an error. But in JavaScript, it's fine.

If you need to "freeze" an object and prevent it from being mutated, you can use `Object.freeze`.

```javascript
const obj1 = Object.freeze({ name: "John" });
obj1.name = "Jane"; // TypeError: Cannot assign to read only property 'name' of object
```

## Prefer const over let

`const` signals that the variable won't change. When used as a practice and you're consistent with it, it makes your code easier to understand. When you spot `let`, you know that the variable will be reassigned. Meaning, that the variable holds multiple values and you should be aware of that.

It's a code smell generally when writing clean code. If a variable has multiple values, it's harder to reason about the code and easier to introduce subtle bugs.
