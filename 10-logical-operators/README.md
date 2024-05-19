# Logical Operators

We're gonna dive into the logical operators: `&&` and `||`.

# AND operator

`&&` is the logical AND operator. It returns `true` if both expressions produce `true`.

```js
const value1 = true;
const value2 = false;

if (value1 && value2) {
  console.log("Both values are true");
} else {
  console.log("One or both values are false");
}
```

# OR operator

`||` is the logical OR operator. It returns `true` if at least one of the expressions produces `true`.

In the example below, `value1` is `true`, so the `if` statement will log "At least one value is true".

```js
const value1 = true;
const value2 = false;

if (value1 || value2) {
  console.log("At least one value is true");
} else {
  console.log("Both values are false");
}
```

# More complex expressions

You can also use AND and OR operators together in more complex expressions. This can be achieved by using parentheses to group expressions.

```js
const value1 = true;
const value2 = false;
const value3 = true;
const value4 = false;

if ((value1 && value2) || (value3 && value4)) {
  console.log("At least one expression is true");
} else {
  console.log("All expressions are false");
}
```

Here, for one of the expressions to produce true, either one of the grouped expressions must be true.
