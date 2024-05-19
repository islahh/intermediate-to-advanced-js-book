# Introduction

One of the unique things with JavaScript is that it is a prototype-based language. This means that objects can inherit properties directly from other objects. This is different from class-based languages, where classes inherit properties from other classes.

JavaScript is also a dynamic language, which means that you can add properties to objects at any time. This is different from static languages, where you have to define the properties of an object when you create it.

You can even reassign values to a new value with a different type. This is different from static languages, where you have to define the type of a property when you create it.

```js
let obj = {
  name: "John",
  age: 30,
};

obj = "I'm now a string";
```

This wouldn't just be possible in some other programming languages.

# Prototypes

In JavaScript, every object has an internal property called `[[Prototype]]`. This is a reference to another object. When you try to access a property on an object, and the property doesn't exist on the object itself, JavaScript will look for the property on the object's prototype.

It's gonna keep looking up the prototype chain until it finds the property or reaches the end of the chain.

# Root level

When you define an object at the root level, it's prototype is `Object.prototype`. This is the root of the prototype chain. It's prototype is `null` because it doesn't have a prototype.

```js
let obj = {
  name: "John",
  age: 30,
};

console.log(obj.toString()); // [object Object]
```

When we declare `obj`, we only set the properties `name` and `age`. But when we call `obj.toString()`, it works, even though we didn't define a `toString` method on `obj`. This is because `obj` inherits the `toString` method from `Object.prototype`.

# What is `Object.prototype`?

As mentioned, `Object.prototype` is the root of the prototype chain. It contains common methods and properties that are available on all objects in JavaScript e.g. `toString`, `valueOf`, `hasOwnProperty`, `isPrototypeOf`, `propertyIsEnumerable`, `toLocaleString`.

# What is `Object`?

`Object` itself is a constructor function. A constructor function is a function that is used to create objects. When you create an object using the object literal syntax `{}`, you are actually using the `Object` constructor function behind the scenes.

```js
let obj = {
  name: "John",
  age: 30,
};

// is the same as
let obj = new Object({
  name: "John",
  age: 30,
});
```

# Your own constructor function

```js
function Person(name, age) {
  this.name = name;
  this.age = age;
}

let john = new Person("John", 30);

console.log(john.name); // John
console.log(john.age); // 30
```

# Create an object with a prototype

You can also create an object with a prototype using `Object.create`.

```js
let personProto = {
  greet() {
    console.log("Hello");
  },
};

let john = Object.create(personProto);

john.greet(); // Hello
```

It's important to note that `greet` is not a property of `john`. It's a property of `personProto`. But because `john` has `personProto` as its prototype, it can access the `greet` method.

`john` won't find `greet` on itself, so it will look up the prototype chain and find it on `personProto`.

To visualize:

```
john -> personProto -> Object.prototype -> null
```

# Okay, what about accessing and modifying prototypes?

For this, you can use `Object.getPrototypeOf` and `Object.setPrototypeOf`. These are modern and recommended ways to access and modify prototypes.

```js
let personProto = {
  greet() {
    console.log("Hello");
  },
};

let john = Object.create(personProto);

console.log(Object.getPrototypeOf(john) === personProto); // true

console.log(john.greet()); // Hello

const newProto = {
  bye() {
    console.log("Bye");
  },
};

Object.setPrototypeOf(john, newProto);

console.log(Object.getPrototypeOf(john) === newProto); // true

console.log(john.bye()); // Bye

console.log(john.greet()); // Error
```

In this example, we begin by creating an object `john` with a prototype `personProto`. We then check if `john`'s prototype is `personProto` using `Object.getPrototypeOf`.

Then we update `john`'s prototype to `newProto` using `Object.setPrototypeOf`. We check if `john`'s prototype is `newProto` using `Object.getPrototypeOf`.

Finally, we call `john.bye()`, which works because `john` now has `newProto` as its prototype. We also call `john.greet()`, which throws an error because `john` no longer has `personProto` as its prototype.

# We're not done yet, `prototype` property

The `prototype` property is a special property of a constructor function. It's a reference to the prototype of the object created by the constructor.

This is hard to explain without an example.

```js
function Person(name, age) {
  this.name = name;
  this.age = age;
}

Person.prototype.greet = function () {
  console.log("Hello ", this.name);
};

const john = new Person("John", 30);
const jane = new Person("Jane", 25);

john.greet(); // Hello John
jane.greet(); // Hello Jane

console.log(Object.getPrototypeOf(john) === Person.prototype); // true
console.log(Object.getPrototypeOf(jane) === Person.prototype); // true
```

`john` and `jane` are instances of `Person`. They do not have the `prototype` property. They have an internal property called `[[Prototype]]`, which is a reference to `Person.prototype`.

They do have a prototype, but that points to `Person.prototype`, not `Person`.

A common misconception here is that `Person.prototype` is the direct prototype of its instances. But the instances' prototypes point to `Person.prototype`.

To visualize:

```
john -> [[Prototype]] -> Person.prototype -> Object.prototype -> null
jane -> [[Prototype]] -> Person.prototype -> Object.prototype -> null
```
