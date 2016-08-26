// HelloWorldWidget is an arbitrary name for any "dumb" component. We do not recommend suffixing
// all your dump component names with Widget.

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

    // Uses lodash to bind all methods to the context of the object instance, otherwise
    // the methods defined here would not refer to the component's class, not the component
    // instance itself.
  }

  render() {
    const { name } = this.props;
    const { data } = this.props;
    const { starred } = this.props;
    console.log({ data })
    console.log({ starred });
    var star
    if ({ starred }) {
      star = <span className="glyphicon glyphicon-star data-clip-started text-primary"></span>
    } else {
      star = <span className="glyphicon glyphicon-star data-clip-started text-primary hidden"></span>
    }
    return (
      <div className="pointer">
        <div className="col-md-3 col-sm-6 data-clip">
          <div className="thumbnail" style={{height: '260 px'}}>
            <h4 className="data-clip-number">
              1. { name }
              star
            </h4>
            <div className="height" style={{height: '140px', overflowY: 'hidden' }}>
              <p style={{maxHeight: '200px'}}>
                { data }
              </p>
            </div>
            <div className="caption text-right">
              <p> Alejo </p>
            </div>
          </div>
        </div>
      </div>
    );
  }
}
