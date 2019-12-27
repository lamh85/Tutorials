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