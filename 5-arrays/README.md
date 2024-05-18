# Arrays

Arrays are a collection of values. They can store any type, including arrays themselves. You can create an array using square brackets `[]`. Here's an example:

```js
const arr = [1, 2, 3];
```

Here, we created an array with three values: `1`, `2`, and `3`.

Arrays are 0-indexed. Meaning, the first element is at index `0`, the second element is at index `1`, and so on. You can access elements in an array using square brackets and the index. Here's an example:

```js
const arr = [1, 2, 3];
arr[0]; // 1
arr[1]; // 2
arr[2]; // 3
```

# Check if something is an array

Since arrays are objects, `typeof` returns `object` for arrays. This is a bit of a problem. However, thankfully, there's a built-in method called `Array.isArray` that checks if something is an array. Here's an example:

```js
const arr = [1, 2, 3];

Array.isArray(arr); // true
```

You can use this method to check if something is an array.

# Destructuring arrays

You can also destructure arrays. Destructuring allows you to unpack values from arrays or properties from objects and store them in variables. Here's an example:

```js
const arr = [1, 2, 3];

const [x, y, z] = arr;
console.log(x, y, z); // 1 2 3
```

## Different from objects

With objects, you can destructure properties in any order and the name must match unless you explicitly rename them. However, with arrays, the order matters. The variables are assigned the values based on their position in the array.

Naming doesn't matter when destructuring arrays.

```js
const arr = [1, 2, 3];

const [firstNumber, secondNumber] = arr;
console.log(firstNumber, secondNumber); // 1 2
```

Here, `firstNumber` is assigned the value `1`, and `secondNumber` is assigned the value `2`. As you can see, naming doesn't matter when destructuring arrays.

# Methods

Arrays have many useful methods. Here are some of the most commonly used ones:

- `push`: adds an element to the end of an array
- `pop`: removes the last element of an array
- `shift`: removes the first element of an array
- `unshift`: adds an element to the start of an array
- `concat`: merges two or more arrays
- `map`: loops over each element and modifies them
- `filter`: filters elements based on a condition
- `find`: finds the first element that satisfies a condition
- `findIndex`: finds the index of the first element that satisfies a condition
- `reduce`: reduces an array to a single value (from left-to-right)
- `forEach`: loops over each element in an array
- `some`: checks if at least one element satisfies a condition
- `every`: checks if all elements satisfy a condition

Let's look at some code:

```js
const arr = [1, 2, 3];

arr.push(4); // [1, 2, 3, 4]
arr.pop(); // [1, 2, 3]
arr.shift(); // [2, 3]
arr.unshift(0); // [0, 2, 3]
```

Let's look at some more advanced methods:

```js
const people = [
  { name: "Lydia", age: 21 },
  { name: "Sarah", age: 22 },
  { name: "Ava", age: 23 },
];

const names = people.map((person) => person.name); // ["Lydia", "Sarah", "Ava"]
const personWithAge21 = people.find((person) => person.age === 21); // { name: "Lydia", age: 21 }
const personWithAge22Index = people.findIndex((person) => person.age === 22); // 1
```

I think `every`, `some` and `filter` are quite handy too:

```js
const people = [
  { name: "Lydia", age: 21 },
  { name: "Sarah", age: 22 },
  { name: "Ava", age: 23 },
];

const allAbove20 = people.every((person) => person.age > 20); // true
const someAbove21 = people.some((person) => person.age > 21); // true, some can drink
const adults = people.filter((person) => person.age > 21); // [{ name: "Sarah", age: 22 }, { name: "Ava", age: 23 }]
```
