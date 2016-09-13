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
    this.props.handleTag(this.props.type, this.props.name);
  }

  render() {
    const { name } = this.props;
    const { show } = this.props;
    var label
    var title
    if (this.props.type == 'channel') {
      label = 'label label-success'
      title = 'channel:'
    } else if (this.props.type == 'user') {
      label = 'label label-info'
      title = 'user:'
    } else {
      label = 'label label-warning'
      title = 'tag:'
    }
    return (
      <span className={ name ? label : 'hidden' }>
        {title} { name } <i className="glyphicon glyphicon-remove" onClick={this.handleRemove}></i>
      </span>
    );
  }
}
