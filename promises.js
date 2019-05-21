// Sources:
// SxS comparison of Promise and async/await: https://medium.com/front-end-weekly/callbacks-promises-and-async-await-ad4756e01d90
// Mozilla: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise
// How to make your own Fetch function: https://stackoverflow.com/questions/30008114/how-do-i-promisify-native-xhr

// How to create a Promise instance:

const thisFunctionReturnsPromsie = () => {
  new Promise((resolve, reject) => {
    // *** This will finish asynchronously ***
    const result = vanillaHttpRequest()
    
    if (result.ok) {
      resolve(result.successMessage)
    } else {
      reject(result.failureMessage)
    }
  })
}

// Calling the function

thisFunctionReturnsPromsie()
  // *** Same value as result.successMessage above ***
  .then(successMessage => {
    // Do something with the result.successMessage
  })
  .catch(failureMessage => {
    // Do something with the result.failureMessage
  })


// How does async and await compare?
// How to wrap the function call inside an async function:

const callPromise = async () => {
  
}

// What does `new Promise` produce?
// An object like this:
{
  then: (callbackFunction) => {
    callbackFunction()
  },
  catch: (callBackFunction) => {
    callbackFunction()
  }
}

// What does `resolve()` do?
const resolve = thenArgument => {
  // Create proprty promiseInstance.then
}