import React, { PropTypes } from 'react';
import _ from 'lodash';

// Simple example of a React "dumb" component
export default class DataClipWidget extends React.Component {
  static propTypes = {
    // If you have lots of data or action properties, you should consider grouping them by
    // passing two properties: "data" and "actions".
  };

  constructor(props, context) {
    super(props, context);
    this.state = { name: this.props.name };
  }

  render() {
    const { name } = this.props;
    return (
      <li>
        <a href="#">{ name }</a>
      </li>
    );
  }
}
