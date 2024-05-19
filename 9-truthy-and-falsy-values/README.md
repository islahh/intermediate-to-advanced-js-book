# Introduction

In JavaScript, we have the concept of truthy and falsy values. A truthy value is a value that's considered true when evaluated as a boolean.

Some code to illustrate this:

```js
const value = 1;

if (value) {
  console.log("Truthy value");
} else {
  console.log("Falsy value");
}
```

Here, `value` is a truthy value because it evaluates to `true` in a boolean context.

A simple way to put it: All values are truthy unless they are defined as falsy.

The falsy values in JavaScript are:

- `false`
- `0`
- `-0`
- `0n` (BigInt zero)
- `""` (empty string)
- `null`
- `undefined`

# Checking for truthy and falsy values

If not using an if statement, you can use the `Boolean` constructor to check if a value is truthy or falsy:

```js
console.log(Boolean(0)); // false
console.log(Boolean("")); // false
console.log(Boolean(1)); // true
```

The Boolean function coerces, in simpler words, transforms the value into a boolean.

# NOT operator

The NOT operator `!` can be used to flip the truthiness of a value:

```js
const True = true;
const False = !True;
```

It can also be used on values other than a boolean:

```js
console.log(!0); // true
console.log(!1); // false
```

How does this work?

The NOT operator `!` coerces the value to a boolean and then flips it.

A common trick is to use the NOT operator to turn a value into a boolean, this can be achieved by using `!!`:

```js
console.log(!!0); // false
console.log(!!1); // true
```

Here, our aim is to preserve the original truthiness of the value but convert it to a boolean. Personally, I prefer using `Boolean` for readability.
