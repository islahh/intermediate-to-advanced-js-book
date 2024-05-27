# Call Stack

- JS is a single threaded language, meaning it can only execute one thing at a time.
- Has a callstack to keep track of what it is doing.
- When a function is called, it is added to the call stack.
- When the function is done, it is removed from the call stack.

```javascript
function first() {
  console.log("first");
  second();
  console.log("first again");
}

function second() {
  console.log("second");
}

first();
```

What happens here?

1. `first()` is called and added to the call stack.
2. `console.log("first")` is called and added to the call stack.
3. `console.log("first")` is removed from the call stack.
4. `second()` is called and added to the call stack.
5. `console.log("second")` is called and added to the call stack.
6. `console.log("second")` is removed from the call stack.
7. `second()` is removed from the call stack.
8. `console.log("first again")` is called and added to the call stack.
9. `console.log("first again")` is removed from the call stack.
10. `first()` is removed from the call stack.

# Execution Context

Well, to be exact, functions aren't the ones pushed onto the call stack. Instead, each function call creates an execution context. This execution context is what is pushed onto the call stack.

Execution context refers to the environment in which the JavaScript code is executed. JavaScript code can never run outside of an execution context.

We'll in a minute dive into what's included in the exeuction context.

When JavaScript starts running, a global execution context is created. This global execution context is the default execution context. When a function is called, a new execution context is created for that function. This new execution context is pushed onto the call stack.

## Components of Execution Context

We have three main things in an execution context:

1. **Variable Environment**: This is where the variables declared within the function are stored. It also stores the function parameters.
2. **Lexical Environment**: This is includes the Variable Environment as the Environment Record and a reference to the outer lexical environment. This outer references is what enables the scope chain. Similar to prototype chain where we can keep going up the chain to find the value of a variable if it doesn't exist in the current scope, which refers to the variable environment in this case.
3. **This**: This refers to the object that the function is a method of. If the function is not a method of any object, `this` refers to the global object.

```js
// Global Execution Context
const globalVar = "I am a global variable";

function outerFunction(outerParam) {
  // outerFunction Execution Context
  // Variable Environment: { outerParam: "I am an outer parameter", outerVar: "I am an outer variable", innerFunction: function }
  // Lexical Environment: { Environment Record: (same as Variable Environment), Outer Lexical Environment Reference: Global Lexical Environment }
  // `this` Binding: depends on call context

  const outerVar = "I am an outer variable";

  function innerFunction(innerParam) {
    // innerFunction Execution Context
    // Variable Environment: { innerParam: "I am an inner parameter", innerVar: "I am an inner variable" }
    // Lexical Environment: { Environment Record: (same as Variable Environment), Outer Lexical Environment Reference: outerFunction's Lexical Environment }
    // `this` Binding: depends on call context

    // Scope Chain from this point: [innerFunction's Environment Record, outerFunction's Environment Record, Global Environment Record]

    const innerVar = "I am an inner variable";

    // Accessing variables from different scopes
    console.log(globalVar); // "I am a global variable"
    console.log(outerVar); // "I am an outer variable"
    console.log(innerVar); // "I am an inner variable"
    console.log(outerParam); // "I am an outer parameter"
    console.log(innerParam); // "I am an inner parameter"
  }

  innerFunction("I am an inner parameter");
}

outerFunction("I am an outer parameter");
```

## Closures clarified

This is why when calling a function that returns another function, if doing this multiple times, we won't share the same variables. Each time a function is called, a new execution context is created, and the variables are stored in that execution context. This is what enables closures.

The "remembering" part in technical terms is the Lexical Environment.

```js
function outerFunction(name) {
  const outerVar = "I am an outer variable: " + name;

  function innerFunction() {
    console.log(outerVar);
  }

  return innerFunction;
}

const firstInnerFunction = outerFunction("first");

const secondInnerFunction = outerFunction("second");

const thirdInnerFunction = outerFunction("third");

firstInnerFunction(); // "I am an outer variable: first"
secondInnerFunction(); // "I am an outer variable: second"
thirdInnerFunction(); // "I am an outer variable: third"
```

# Web APIs, Web APIs environment, Callback Queue and Event loop

- Web APIs are functions or methods provided by the browser. These are not part of the JavaScript engine.
- Examples, `setTimeout`, `fetch`, `XMLHttpRequest`, `addEventListener`, etc.
- If calling setTimeout, we'd block the call stack until the time is up. This is where the Web APIs environment comes in.
- Web APIs are popped off the call stack and executed in the Web APIs environment.
- When done, they're sent to the Callback Queue and wait for the call stack to be empty.
- When the call stack is empty, the Event Loop checks the Callback Queue and pushes the callbacks onto the call stack.
- Event Loop is what completes the cycle of the call stack, Web APIs, Callback Queue and Event Loop.
- That's when the callbacks are actually executed.

```js
setTimeout(() => {
  console.log("I am a callback");
}, 0);

console.log("I am not a callback");
```

1. `setTimeout` is added to the call stack.
2. The `setTimeout` function is executed, which schedules the callback to be run after the specified delay (in this case, 0 milliseconds). The callback function itself is not executed at this point.
3. `setTimeout` is removed from the call stack.
4. The callback function is sent to the Web APIs environment to be handled by the browser's timer mechanism.
5. `console.log("I am not a callback")` is added to the call stack and executed.
6. `console.log("I am not a callback")` is removed from the call stack.
7. After the specified delay (which is practically immediate in this case), the Web APIs environment sends the callback function to the Callback Queue.
8. The Event Loop checks if the call stack is empty. If it is, it takes the first callback function from the Callback Queue and pushes it onto the call stack.
9. The callback function `() => { console.log("I am a callback"); }` is added to the call stack.
10. The callback function is executed, and `console.log("I am a callback")` is added to the call stack.
11. `console.log("I am a callback")` is executed and removed from the call stack.
12. The callback function is removed from the call stack.

So, when `setTimeout` is executed, it doesn't directly add the `console.log` to the call stack. Instead, it schedules the callback function to be executed later by the Web APIs environment and the Event Loop mechanism.

The callback queue is also referred to as the macrotask queue.
