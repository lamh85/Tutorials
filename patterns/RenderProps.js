class Hover extends React.Component {
  state = { hovering: false }
  mouseOver = () => this.setState({ hovering: true })
  mouseOut = () => this.setState({ hovering: false })
  render() {
    return (
      <div onMouseOver={this.mouseOver} onMouseOut={this.mouseOut}>
        // this.state.hovering is either true or false
        {this.props.render(this.state.hovering)}
      </div>
    )
  }
}

<Hover render={(hovering) =>
  <DailyChart hovering={hovering}>
}>

function DailyChart (props) {
  return (
    <>
      // Created by <Hover/>'s state.hovering
      {props.hovering === true
        ? <Tooltip id={this.props.id}/>
        : null}
      <Chart
        type='daily'
        onMouseOver={this.mouseOver}
        onMouseOut={this.mouseOut}
      />
    </>
  )
}