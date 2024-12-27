# Event-Driven Architecture (EDA) in Node.js

Event-Driven Architecture (EDA) is a software design pattern where the flow of the application is determined by events. An event can be a user action, a system signal, or a message. Node.js uses EDA extensively, leveraging the **EventEmitter** class.

---

## **Metaphor: A Coffee Shop**

Imagine a coffee shop scenario:
1. **Barista**: Prepares coffee.
2. **Customer**: Places an order.
3. **Notification Bell**: Rings when the coffee is ready.

### **Steps**:
- The **customer** (event producer) places an order.
- The **barista** (event listener) listens for orders and prepares the coffee.
- When the coffee is ready, the **barista rings the bell** (emit event).
- The **customer** hears the bell and collects the coffee.

---

## **Example: Event-Driven Coffee Shop in Node.js**

Below is the Node.js implementation of the coffee shop metaphor:

### **Code**:
```javascript
const EventEmitter = require('events');

// Create a CoffeeShop class that extends EventEmitter
class CoffeeShop extends EventEmitter {
  placeOrder(customerName, coffeeType) {
    console.log(`${customerName} has ordered a ${coffeeType}.`);
    setTimeout(() => {
      // Emit 'coffee-ready' event after preparing the coffee
      this.emit('coffee-ready', customerName, coffeeType);
    }, 2000); // Simulate coffee preparation time
  }
}

// Create an instance of the CoffeeShop
const shop = new CoffeeShop();

// Listener: Handle 'coffee-ready' event
shop.on('coffee-ready', (customerName, coffeeType) => {
  console.log(`Ding! ${customerName}, your ${coffeeType} is ready!`);
});

// Place orders
shop.placeOrder('Alice', 'Latte');
shop.placeOrder('Bob', 'Espresso');

Alice has ordered a Latte.
Bob has ordered an Espresso.
Ding! Alice, your Latte is ready!
Ding! Bob, your Espresso is ready!
```

# Key Concepts
1. Event Emitter: The CoffeeShop class emits events like coffee-ready.
2. Event Listener: The shop.on method listens for specific events and executes a callback.
3. Asynchronous Flow: Events occur asynchronously, enabling the system to handle multiple tasks concurrently.

# Advantages of EDA in Node.js
- Decoupling: Producers and consumers are loosely connected.
- Scalability: Efficiently handles multiple concurrent events.
- Real-Time Systems: Ideal for real-time applications like chat apps or live notifications.

# Real-World Applications
- Web Servers: Handling HTTP requests (e.g., request and response events).
- Chat Applications: Updating new messages in real-time.
- Microservices: Event-driven communication between services.
- IoT Devices: Sensors emitting events for a central hub to process.
