import React, { PropTypes } from 'react';
import _ from 'lodash';

// Simple example of a React "dumb" component
export default class Tag extends React.Component {
  static propTypes = {
    // If you have lots of data or action properties, you should consider grouping them by
    // passing two properties: "data" and "actions".
  };

  constructor(props, context) {
    super(props, context);
    this.state = { name: '', show: false };
    _.bindAll(this, 'handleRemove');
  }

  handleRemove() {
    this.props.handleTag();
  }

  render() {
    const { name } = this.props;
    const { show } = this.props;
    console.log(name);
    console.log(name ? true : false);
    return (
      <span className={ name ? 'label label-success' : 'hidden' }>
        channel: { name } <i className="glyphicon glyphicon-remove" onClick={this.handleRemove}></i>
      </span>
    );
  }
}
