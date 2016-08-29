import React, { PropTypes } from 'react';
import SideBar from './SideBar';
import DataClip from './DataClipWidget';
import Tag from './Tag';
import _ from 'lodash';

export default class Dashboard extends React.Component {

  static propTypes = {
    // If you have lots of data or action properties, you should consider grouping them by
    // passing two properties: "data" and "actions".
  };

  constructor(props, context) {
    super(props, context);
    this.state = {
      channelTagName: '',
      dataclips: this.props.dataclips,
      filteredDataclips: this.props.dataclips,
      filterByChannel: '',
      filterByUser: ''
    };
    _.bindAll(this, 'showTag', 'hideTag');
  }

  showTag(id, name, type) {
    this.setState({
      channelTagName: name,
      filterByChannel: id
    }, this.filterDataclips);
  }

  filterDataclips() {
    let dataclips = this.state.dataclips
    let byChannel = this.state.filterByChannel
    dataclips = byChannel ? _.filter(dataclips, function(dataclip){ return dataclip.channel_id == byChannel }) : dataclips
    this.setState({filteredDataclips: dataclips});
  }

  hideTag() {
    this.setState({ filteredByChannel: '' });
    this.setState({filteredDataclips: this.state.dataclips});
  }

  render() {
    var component = this
    let teamName = this.props.team.name;
    let channels = this.props.channels.map(function(channel) {
      return (
        <SideBar key={channel.id} id={channel.id} name={channel.name}
        handleTag={component.showTag}/>
      );
    });
    let dataclips = this.state.filteredDataclips.map(function(dataclip) {
      return (
        <DataClip key={dataclip.id} name={dataclip.name} data={dataclip.data}
        starred={dataclip.starred}/>
      );
    });
    return (
      <div id="dashboard" className="container-fluid">
        <div className="row">
          <div className="col-md-2 col-sm-3 filter-options-box-1">
            <div className="col-md-12">
              <h2>Channels</h2>
              <ul>
                {channels}
              </ul>
            </div>

            <div className="col-md-12">
              <h2>People</h2>
              <ul>
                {/* peoples component */}
              </ul>
            </div>

            <div className="col-md-12">
              <h2>Tags</h2>
              <ul>
                {/* tags component */}
              </ul>
            </div>
          </div>
          <div className="col-md-10 col-sm-9 col-xs-12 text-left">
            <div className="col-xs-12 filters-container">
              { this.state.channelTagName ? <Tag name={this.state.channelTagName}
                show={this.state.showChannelTag} handleTag={component.hideTag} /> : null  }
              { this.state.channelTagName ? <Tag name={this.state.channelTagName}
                show={this.state.showChannelTag} handleTag={component.hideTag} /> : null  }
              {/* tag tags component - possibly different than the other two */}
            </div>

            <div className="col-md-12 col-xs-12 order-options-container">
              <h1 id="team-name">{ teamName }</h1>
            </div>
            <div className="row">
              <div className="col-md-12">
                { dataclips }
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
}
