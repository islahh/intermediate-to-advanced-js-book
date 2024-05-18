# Equality and Type Coercion

Since this is a common topic, I assume you're familiar with it already, if not, you're gonna learn it today.

In JavaScript, to check equality between two values, you can either use `==` or `===` operators. The `==` operator checks for equality after doing type coercion, while the `===` operator checks for equality without type coercion.

```javascript
let a = 1;
let b = "1";

console.log(a == b); // true
console.log(a === b); // false
```

What's the difference?

With a double equal sign `==`, JavaScript will try to convert the values to the same type before comparing them. In the example above, JavaScript converts the string `"1"` to a number `1` before comparing them.

As for the triple equal sign `===`, JavaScript doesn't do any type coercion. It compares the values as they are. If the types are different, it stops and returns `false`.

# == is slower than ===

Fun fact: `==` can be up to 15 times slower than `===`. It's because more work goes into trying to convert the values to the same type before comparing them.
