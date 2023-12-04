import React, { PropTypes } from 'react';
import _ from 'lodash';

// Simple example of a React "dumb" component
export default class SideBar extends React.Component {
  static propTypes = {
    // If you have lots of data or action properties, you should consider grouping them by
    // passing two properties: "data" and "actions".
  };

  constructor(props, context) {
    super(props, context);
    this.state = { name: this.props.name };
    _.bindAll(this, 'handleClick');
  }

  handleClick() {
    this.props.handleTag(this.props.id, this.props.name, this.props.type)
  }

  render() {
    const { name } = this.props;
    return (
      <li>
        <a onClick={this.handleClick}>{ name }</a>
      </li>
    );
  }
}
