# Patterns
## Higher Order Function
```javascript
const firstResponder = emergency => {
  return {
    fire: item => douseFlames(item),
    dying: item => revive(item),
    crime: item => robocopTreatment(item)
  }[emergency]
}

const mapFunction = firstResponder('fire)
burningBuildings.map(mapFunction)
```
## Higher Order Component / Inversion of Control
https://tylermcginnis.com/react-higher-order-components/
```javascript
function withHover(Component) {
  return class WithHover extends React.Component {
    state = { hovering: false }
    mouseOver = () => this.setState({ hovering: true })
    mouseOut = () => this.setState({ hovering: false })
    render() {
      return (
        <div onMouseOver={this.mouseOver} onMouseOut={this.mouseOut}>
          <Component hovering={this.state.hovering} />
        </div>
      );
    }
  }
}
```
# Statements
## Can Add Properties to Functions (proving that functions are objects)
```javascript
// We can add properties to functions like we do with objects
greeting.lang = 'English';
// Prints 'English'
console.log(greeting.lang);
```
## Flatten a two dimensional array
```javascript
// .concat is used for merging multiple arrays. Each argument is an array:
[].concat([1,2,3], [4,5,6])

// Therefore, can be used to flatten an array via spread operator
const 2DArray = [['set one'], ['set two']]
const flattened = [].concat(..2DArray)
```