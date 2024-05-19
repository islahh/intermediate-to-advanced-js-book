# Spread and Rest Operators

Both the spread and rest operators are represented by three dots (`...`). They are used in different contexts and have different purposes.

# Rest Operator

The rest operator is used to collect multiple elements into a single array. It is primarily used in function parameters and array destructuring.

```js
function sum(...numbers) {
  return numbers.reduce((total, num) => total + num, 0);
}
console.log(sum(1, 2, 3, 4)); // Outputs: 10
```

Here, the `...numbers` syntax collects all arguments passed to the `sum` function into a single array.

```js
const [first, second, ...rest] = [1, 2, 3, 4, 5];
console.log(first); // 1
console.log(second); // 2
console.log(rest); // [3, 4, 5]
```

In array destructuring, the rest operator collects the remaining elements into a new array.

Key points:

- The rest operator is used to collect multiple elements into a single array.
- Must be last in the parameter list or destructuring assignment. Last can also be first if the only parameter or element you want to collect is the first one.

# Spread Operator

Spread operator isn't about collecting and grouping things into an array. Instead, it's about spreading or unpacking elements.

```js
function sum(a, b, c) {
  return a + b + c;
}
const numbers = [1, 2, 3];
console.log(sum(...numbers)); // Outputs: 6
```

Here, the `...numbers` syntax spreads the array elements into individual arguments for the `sum` function.

```js
const arr1 = [1, 2, 3];
const arr2 = [4, 5, 6];
const combined = [...arr1, ...arr2];
console.log(combined); // [1, 2, 3, 4, 5, 6]
```

Here, we're merging two arrays into a single array using the spread operator.

It also works with objects:

```js
const obj1 = { a: 1, b: 2 };
const obj2 = { c: 3, d: 4 };
const merged = { ...obj1, ...obj2 };
console.log(merged); // { a: 1, b: 2, c: 3, d: 4 }
```
