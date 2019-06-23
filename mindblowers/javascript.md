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
```javascript
var hello
{
  hello: 'world',
  foo: 'bar', // another comment
}
```