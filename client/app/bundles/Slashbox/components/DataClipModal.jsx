import React, { PropTypes } from 'react';
import Modal from 'react-modal';

export default class DataClipWidget extends React.Component {
  static propTypes = {
    visible: React.PropTypes.bool.isRequired,
    dataClip: React.PropTypes.object,
    onRequestClose: React.PropTypes.func
  };

  componentWillMount() {
    Modal.setAppElement('body');
  }

  render() {
    const { name,data,starred,userImg,userName } = this.props;
    return (
      <div>
        <Modal
          isOpen={this.props.visible}
          onRequestClose={this.props.onRequestClose}
          className="modal-dialog modal-md"
          overlayClassName="modal-backdrop">
          {(() => {
            if(this.props.visible) {
              return(
                <div className="modal-content">
                  <div className="modal-header">
                    <button type="button" className="close"><span onClick={this.props.onRequestClose}>&times;</span></button>
                    <h4 className="modal-title">{this.props.dataClip.name}</h4>
                  </div>
                    <div className="modal-body">
                      <div className="markdown">
                        <p className="text-center">{this.props.dataClip.data}</p>
                      </div>
                    </div>

                    <div className="modal-footer">
                      {this.props.dataClip.tags.map((tag,i) => <span key={i} className="label label-primary">{tag}</span> )}
                    </div>
                </div>
              )
            }
          })()}
        </Modal>
      </div>
    );
  }
}
