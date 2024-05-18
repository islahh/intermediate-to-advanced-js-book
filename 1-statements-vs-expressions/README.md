# Expressions

An expression is a piece of code that produces a value. For example, `2 + 2` is an expression that produces the value `4`. Expressions can be as simple as a single value or as complex as a function call that returns a value.

```javascript
5 + 3; // evaluates to the value 8
"Hello, " + "World!"; // evaluates to the string "Hello, World!"
x[(1, 2, 3)] // evaluates to the value of the variable x
  .pop(); // evaluates to the number 3
```

Expressions can be used as part of a statement, such as assigning the result of an expression to a variable or using an expression as a condition in an if statement

Key traits of expressions:

- They produce a value when evaluated.
- They can be used wherever a value is expected, such as in function arguments or assignments.
- They can be combined with other expressions using operators to form more complex expressions.

# Statements

A statement is a piece of code that performs an action or controls the flow of the program. Statement do not produce values. They're often composed of expressions.

```javascript
let x = 5; // variable declaration and assignment statement
console.log("Hello"); // function call statement
if (x > 3) { ... } // conditional statement
for (let i = 0; i < 10; i++) { ... } // loop statement
```

They are typically terminated with a semicolon (;), although when configured if you desire, semicolons can be omitted.

Key traits of statements:

- They perform actions or control the program flow.
- They are often composed of expressions but don't necessarily produce a value themselves.
- They are used to structure the program and control its execution.

# Their Differences

The main difference between expressions and statements is that expressions produce a value, while statements perform actions or control the program flow.

However, there is a relationship between expressions and statements. Expressions can be used as part of statements, and some statements can contain expressions.

```javascript
let x = 5 + 3; // the expression '5 + 3' is part of the assignment statement
if (x > 10) { ... } // the expression 'x > 10' is used as the condition in the if statement
```
