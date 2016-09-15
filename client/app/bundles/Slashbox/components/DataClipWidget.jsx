import React, { PropTypes } from 'react';
import _ from 'lodash';

export default class DataClipWidget extends React.Component {
  static propTypes = {
    name: PropTypes.string.isRequired,
    data: PropTypes.string.isRequired,
    starred: PropTypes.bool.isRequired,
    userImg: PropTypes.string,
    userName: PropTypes.string,
    onClick: PropTypes.func
  };
  render() {
    const { name,data,starred,userImg,userName } = this.props;
    return (
      <div className="pointer" onClick={this.props.onClick}>
        <div className="col-md-3 col-sm-6 data-clip">
          <div className="thumbnail" style={{height: '260 px'}}>
            <h4 className="data-clip-number">
              {(() => {
                if(starred) {
                  return <span className="glyphicon glyphicon-star data-clip-started text-primary"></span>
                }
              })()}
              { name }
            </h4>
            <div className="height" style={{height: '140px', overflowY: 'hidden' }}>
              <p style={{maxHeight: '200px'}}>
                { data }
              </p>
            </div>
            <div className="caption text-right">
              <p><img src={userImg} style={{width: 40, height: 40, borderRadius: '100%'}}/> {userName} </p>
            </div>
          </div>
        </div>
      </div>
    );
  }
}
