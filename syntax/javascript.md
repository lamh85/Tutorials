# Named Function Expression
https://medium.com/@raviroshan.talk/javascript-function-declaration-vs-expression-f5873b8c7b38

```javascript
var num1 = 10;
var num2 = 20;

// It is named "addFunction"
// It is expressed as "addVariable"
var addVariable = function addFunction(param1, param2) {
   var res = param1 + param2;
   if (res === 30) {
        // Can call itself
        res = addFunction(res, 10);
   }
   return res;
}

// Can call via expression
var result = addVariable(num1, num2); // ==> 40
```
# OOP

How _prototype_ OOP is different from _classical_ OOP:
* You can create a long change of copies.
* Any copy itself can be a prototype for another copy.
* Thus a chain.

* Creating new copies is NOT cloning.

## The Keyword `new`
* https://codeburst.io/javascript-for-beginners-the-new-operator-cee35beb669e
* https://medium.com/javascript-in-plain-english/proto-vs-prototype-in-js-140b9b9c8cd5

```javascript
function Student(name, age) {
  this.name = name;
  this.age = age;
}

var first = new Student('John', 26);

first.__proto__.constructor.toString()
/*
RETURNS:

"function Student(name, age) {
  this.name = name;
  this.age = age;
}"

.__proto__ means the origin of the instance
*/

Student.prototype == first.__proto__
// => true
// The two properties are aliases. The only difference is that one is used for the class, and the other is for the instance.
```

## `class` is Syntax Sugar

https://www.freecodecamp.org/news/demystifying-javascripts-new-keyword-874df126184c/

```javascript
class User {
  constructor(name) {
    this.name = name
  }
}

const john = new User('John')

john.__proto__.constructor
// => [Function: User]
```

## DOM API as an example

```javascript
div = document.querySelector('div')

div.__proto__.constructor
// => ƒ HTMLDivElement() { [native code] }
```

# `typeof` is unreliable

https://2ality.com/2017/08/type-right.html

The possible outputs for `typeof`: https://www.w3resource.com/javascript/operators/typeof.php

The Javascript **primitives**: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Data_structures

Combined together

`typeof` | Primitive or Object
---------|----------
`object`|(not a primitive)<br/>Objects, Arrays, `null`
`boolean`|Boolean
`function`|(not a primitive)<br/>Function
`number`|Number
`bigint`|BigInt
`string`|String
`undefined`|Undefined
`symbol`|Symbol

# Background Workers

Use messaging to communicate
* https://www.html5rocks.com/en/tutorials/workers/basics/
* https://jakearchibald.com/2015/tasks-microtasks-queues-and-schedules/

# The function `requestAnimationFrame`

https://stackoverflow.com/questions/38709923/why-is-requestanimationframe-better-than-setinterval-or-settimeout