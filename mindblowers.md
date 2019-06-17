# Ruby

## Patterns

```ruby
# Self Instantiation

class Server
  def self.run(args)
    new(args).real_run
  end

  def initialize(args)
  end

  def real_run
  end
end

Server.run
```

## Statements
```ruby
# Square Brackets is a Method
hash = { hello: "world" }
hash.try([], :hello)


```

# Javscript

## Patterns
```javascript
// Higher Order Component (Inversion of Control)
// https://tylermcginnis.com/react-higher-order-components/

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

## Statements
```javascript
var hello
{
  hello: 'world',
  foo: 'bar', // another comment
}
```