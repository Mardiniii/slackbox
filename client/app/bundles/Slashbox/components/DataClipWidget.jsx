import React, { PropTypes } from 'react';
import _ from 'lodash';

export default class DataClipWidget extends React.Component {

  render() {
    const { name } = this.props;
    const { data } = this.props;
    const { starred } = this.props;
    var star
    if (starred) {
      star = <span className="glyphicon glyphicon-star data-clip-started text-primary"></span>
    } else {
      star = <span className="glyphicon glyphicon-star data-clip-started text-primary hidden"></span>
    }
    return (
      <div className="pointer">
        <div className="col-md-3 col-sm-6 data-clip">
          <div className="thumbnail" style={{height: '260 px'}}>
            <h4 className="data-clip-number">
              { star }
              { name }
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
