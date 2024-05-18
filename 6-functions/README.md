# Function declaration and expression

In JavaScript, functions are first-class citizens, meaning they can be assigned to variables, passed as arguments, and returned from other functions. After all, functions are objects in JavaScript. So that should be no surprise.

# Function declaration and expression

There are two ways to define a function in JavaScript: function declaration and function expression.

Function declaration is the most common way to define a function. It starts with the `function` keyword followed by the function name and a pair of parentheses. The function body is enclosed in curly braces `{}`. Here's an example:

```js
function greet() {
  console.log("Hello, world!");
}
```

Function expressions, on the other hand, are defined by creating a variable and assigning an anonymous function to it. Here's an example:

```js
const greet = function () {
  console.log("Hello, world!");
};

greet(); // Hello, world!
```

# Arrow functions

You're also likely familiar with arrow functions, which are a more concise way to write functions. Arrow functions are defined using the `=>` syntax. Here's an example:

```js
const greet = () => {
  console.log("Hello, world!");
};
```

# `this` context

`this` refers to the object that the function is a property of. The object that's currently executing the function. If the function is not a property of an object, `this` refers to the global object (in a browser, this is the `window` object). Here's an example:

```js
function sayHiDeclaration() {
  console.log(this);
}

function sayHiExpression = function() {
  console.log(this);
}

const sayHiArrow = () => {
  console.log(this);
};

sayHiDeclaration(); // window
sayHiExpression(); // window
sayHiArrow(); // window
```

# Arrow functions do not have their own `this`

Let's take a look at this example:

```js
const myObject = {
  name: "John",
  greet: function () {
    console.log(`Hello, my name is ${this.name}`);
  },
};

myObject.greet(); // Output: Hello, my name is John
```

This works fine. `this` points to `myObject` because `greet` is a property of `myObject`.

Now, let's try the same thing with an arrow function:

```js
const myObject = {
  name: "John",
  greet: () => {
    console.log(`Hello, my name is ${this.name}`);
  },
};

myObject.greet(); // Output: Hello, my name is undefined
```

This doesn't work as expected, why?

Arrow functions do not have their own `this`. They inherit `this` from the parent scope. In this case, `this` is the global object, which doesn't have a `name` property.

## Surprising example

```js
const myObject = {
  name: "John",
  greet: {
    greetInner: () => {
      console.log(`Hello, my name is ${this.name}`);
    },
  },
};

myObject.greet.greetInner(); // Output: Hello, my name is undefined
```

Maybe you'd expect `this` to point to `myObject`, but it doesn't. `this` still points to the global object. The reason for that is because `greetInner` inherits `this` from the parent scope. The next parent scope is the global object. An object doesn't create a new scope. In the code example, there is no "parent" besides the global object that `greetInner` can inherit `this` from.

## How would it look like when arrow functions inherit `this` from the parent scope?

```js
const myObject = {
  name: "John",
  greet: function () {
    const greetInner = () => {
      console.log(`Hello, my name is ${this.name}`);
    };
    greetInner();
  },
};

myObject.greet(); // Output: Hello, my name is John
```

Here, `this` refers to `myObject` because `greetInner` is defined inside the `greet` method, which is a property of `myObject`. `greet` importantly is a regular function, not an arrow function. This creates a new scope with `this` pointing to `myObject`.

`greetInner` is an arrow function, but it inherits `this` from the parent scope, which is `myObject`. So it looks at the next `this` in the scope chain, finds that `greet` has one which points to `myObject`, and uses that.

# Changing the value of `this`

This is possible with `call()`, `apply()`, and `bind()` methods.

`call()` and `apply()` are used to call a function with a given `this` value and arguments. The difference between them is that `call()` accepts arguments as a comma-separated list, while `apply()` accepts arguments as an array.

```js
const person = {
  name: "John",
};

function greet(greeting) {
  console.log(`${greeting}, my name is ${this.name}`);
}

greet.call(person, "Hello"); // Output: Hello, my name is John

greet.apply(person, ["Hello"]); // Output: Hello, my name is John
```

As for `bind()`, it creates a new function that, when called, has its `this` keyword set to the provided value.

```js
const person = {
  name: "John",
};

function greet(greeting) {
  console.log(`${greeting}, my name is ${this.name}`);
}

const greetPerson = greet.bind(person);

greetPerson("Hello"); // Output: Hello, my name is John
```

# Returning objects

You can return objects from functions. Here's an example:

```js
function createUser(name, age) {
  return {
    name: name,
    age: age,
  };
}

const user = createUser("John", 30);

const user2 = createUser("Jane", 25);

console.log(user); // Output: { name: 'John', age: 30 }
console.log(user2); // Output: { name: 'Jane', age: 25 }
```

I hope that's clear. One thing to note is that every time you return an object from a function, a new object is created. That's why `user` and `user2` are different objects in memory, even if the keys and values were the same.

# Returning functions

You can also return functions from functions. Here's an example:

```js
function createGreeter(greeting) {
  return function (name) {
    console.log(`${greeting}, ${name}!`);
  };
}

const greet = createGreeter("Hello");

greet("John"); // Output: Hello, John!
greet("Jane"); // Output: Hello, Jane!

const secondGreet = createGreeter("Hi");

secondGreet("John"); // Output: Hi, John!
secondGreet("Jane"); // Output: Hi, Jane!
```

This is quite cool, because you can create functions that are specific to a certain context. In this case, `greet` and `secondGreet` are both functions that greet someone, but they use different greetings. This gives us flexibility and helps us create reusable code.

This brings us to a very important concept in JavaScript: closures.

# Closures

Closures is a function's ability to remember and access its lexical scope even when it's executed outside that scope.

Let's slow down for a second, what's a lexical scope?

```js
function greet(greeting, name) {
  const message = `${greeting}, ${name}!`;
  return function innerGreet() {
    const innerMessage = `${message} How are you?`;
    console.log(innerMessage);
  };
}

const greetJohn = greet("Hello", "John");
const greetJane = greet("Hi", "Jane");

greetJohn(); // Output: Hello, John! How are you?
greetJane(); // Output: Hi, John! How are you?
```

The lexical scope of a function is the scope in which the function is defined. During definition, a function has access to its lexical scope. This is the scope in which the function was defined, not where it's called. The scope that's around the function when it's defined.

`innerGreet` has access to `message` and `name` during it's definition.

The cool part: Let's start with `greet`. When `greet` is called, it returns `innerGreet`. `innerGreet` has access to `message` and `name` even though it's executed outside of `greet`. This is because of closures.

When a function is defined, it captures its lexical scope. During invocation, it has access to that scope. The function "remembers" the state of its lexical scope during definition. The thing that makes this powerful is the fact that the closures aren't shared. So `greetJohn` and `greetJane` have their own `message` and `name`. They won't collide with each other.

That's the power of closures which many fail to highlight. It's not just about a function being able to remember all the variables in its lexical scope. It's about the fact that each closure is unique and has its own state.

# Higher-order functions

This brings us to the final topic: higher-order functions. A higher-order function is a function that takes a function as an argument or returns a function. We've kind of seen this already with `createGreeter` and `greet`.

The cool part here is understanding how you can take functions, use them as arguments, and then still go the extra mile and return a new function if you wish.

Let's look at an example:

```js
// Higher-order function that takes a function as an argument
function applyOperation(numbers, operation) {
  return numbers.map(operation);
}

// Function to square a number
function square(number) {
  return number ** 2;
}

// Function to double a number
function double(number) {
  return number * 2;
}

const numbers = [1, 2, 3, 4, 5];

// Using the higher-order function with different operations
const squaredNumbers = applyOperation(numbers, square);
console.log(squaredNumbers); // Output: [1, 4, 9, 16, 25]

const doubledNumbers = applyOperation(numbers, double);
console.log(doubledNumbers); // Output: [2, 4, 6, 8, 10]
```

Here, `applyOperation` is a higher-order function that takes an array of numbers and a function as arguments. It then maps over the numbers and applies the function to each number.

This is also called a callback function. This style of programming is popular when building libraries because you let the user of a function decide what should happen with the data.

You could also write double numbers like this:

```js
applyOperation(numbers, (number) => number * 2);
```

# Inversion of control

This brings us to the last topic when it comes to functions: inversion of control.

Let's say we have a function that takes an array of elements and this function is supposed to filter out all the elements that are greater than 10. Here's how you could write it:

```js
function filterGreaterThan10(numbers) {
  return numbers.filter((number) => number > 10);
}

filterGreaterThan10([1, 5, 10, 15, 20]); // Output: [15, 20]
```

But now a new requirement comes in. You need to filter out all the elements that are less than 10. You could write a new function for that:

```js
function filterLessThan10(numbers) {
  return numbers.filter((number) => number < 10);
}

filterLessThan10([1, 5, 10, 15, 20]); // Output: [1, 5]
```

But this is repetitive. You're doing the same thing, just with a different condition. This is where inversion of control comes in. Instead of writing two functions, you could write a single function that takes a filter function as an argument:

```js
function filterNumbers(numbers, filterFunction) {
  return numbers.filter(filterFunction);
}

filterNumbers([1, 5, 10, 15, 20], (number) => number > 10); // Output: [15, 20]

filterNumbers([1, 5, 10, 15, 20], (number) => number < 10); // Output: [1, 5]
```
