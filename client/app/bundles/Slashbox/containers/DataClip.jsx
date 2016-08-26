import React, { PropTypes } from 'react';
import DataClipWidget from '../components/DataClipWidget';
import _ from 'lodash';

// Simple example of a React "smart" component
export default class DataClip extends React.Component {
  static propTypes = {
    name: PropTypes.string.isRequired, // this is passed from the Rails view
  };

  constructor(props, context) {
    super(props, context);

    // How to set initial state in ES6 class syntax
    // https://facebook.github.io/react/docs/reusable-components.html#es6-classes
    this.state = { name: this.props.name,
                   data: this.props.data,
                   starred: this.props.starred };

    // Uses lodash to bind all methods to the context of the object instance, otherwise
    // the methods defined here would not refer to the component's class, not the component
    // instance itself.
  }

  render() {
    return (
      <div>
        <DataClipWidget name={this.state.name} data={this.state.data}
        starred={this.state.starred}/>
      </div>
    );
  }
}
