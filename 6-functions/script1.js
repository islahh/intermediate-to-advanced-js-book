function greet(greeting, name) {
  const message = `${greeting}, ${name}!`;
  return function innerGreet() {
    const innerMessage = `${message} How are you?`;
    console.log(innerMessage);
  };
}

const greetJohn = greet("Hello", "John");
const greetJane = greet("Hi", "Jane");
