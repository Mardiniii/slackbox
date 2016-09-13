import React, { PropTypes } from 'react';
import SideBar from './SideBar';
import DataClip from './DataClipWidget';
import Tag from './Tag';
import _ from 'underscore';

export default class Dashboard extends React.Component {

  static propTypes = {
    // If you have lots of data or action properties, you should consider grouping them by
    // passing two properties: "data" and "actions".
  };

  constructor(props, context) {
    super(props, context);
    this.state = {
      channelTagName: '',
      userTagName: '',
      dataclips: this.props.dataclips,
      filteredDataclips: this.props.dataclips,
      filterByChannel: '',
      filterByUser: '',
      filterByTags: []
    };
    _.bindAll(this, 'showTag', 'hideTag');
  }

  showTag(id, name, type) {
    if (type == 'channel') {
      this.setState({
        channelTagName: name,
        filterByChannel: id
      }, this.filterDataclips);
    } else if (type == 'user') {
      this.setState({
        userTagName: name,
        filterByUser: id
      }, this.filterDataclips);
    } else {
      let tags = this.state.filterByTags.push(name);
      this.setState({
        filterByTags: this.state.filterByTags
      }, this.filterDataclips);
    }
  }

  filterDataclips() {
    let dataclips = this.state.dataclips
    let byChannel = this.state.filterByChannel
    let byUser = this.state.filterByUser
    let byTags = this.state.filterByTags
    dataclips = byChannel ? _.filter(dataclips, function(dataclip){ return dataclip.channel_id == byChannel }) : dataclips
    dataclips = byUser ? _.filter(dataclips, function(dataclip){ return dataclip.user_id == byUser }) : dataclips
    dataclips = byTags.length > 0 ? _.filter(dataclips, function(dataclip){ return _.intersection(dataclip.data.split(' '), byTags, byTags).length > 0 }) : dataclips
    this.setState({filteredDataclips: dataclips});
  }

  hideTag(type, name) {
    if (type == 'channel') {
      this.setState({ filterByChannel: '', channelTagName: '' }, this.filterDataclips);
    } else if (type == 'user') {
      this.setState({ filterByUser: '', userTagName: '' }, this.filterDataclips);
    } else {
      let tagsArray = _.without(this.state.filterByTags, name);
      this.setState({ filterByTags: tagsArray }, this.filterDataclips);
    }
  }

  getUserData(dataclip) {
    let user = _.filter(this.props.users, function(user) {
                 return user.id == dataclip.user_id
               })
    return {name: user[0].username, image: user[0].image}
  }

  render() {
    var component = this
    let teamName = this.props.team.name;
    let channels = this.props.channels.map(function(channel) {
      return (
        <SideBar key={channel.id} id={channel.id} name={channel.name} type="channel"
        handleTag={component.showTag}/>
      );
    });
    let users = this.props.users.map(function(user) {
      return (
        <SideBar key={user.id} id={user.id} name={user.username} type="user"
        handleTag={component.showTag}/>
      );
    });
    let sideBarTags = this.props.tags.map(function(tag) {
      return (
        <SideBar key={tag.id} id={tag.id} name={tag.name} type="tag"
        handleTag={component.showTag}/>
      );
    });
    let tags = this.state.filterByTags.map(function(tag) {
      return (
        <Tag key={tag} name={tag} handleTag={component.hideTag} type="tag" />
      )
    });
    let dataclips = this.state.filteredDataclips.map(function(dataclip) {
      let userData = component.getUserData(dataclip)
      return (
        <DataClip key={dataclip.id} name={dataclip.name} data={dataclip.data}
        userImg={userData.image} userName={userData.name}
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
                {users}
              </ul>
            </div>

            <div className="col-md-12">
              <h2>Tags</h2>
              <ul>
                {sideBarTags}
              </ul>
            </div>
          </div>
          <div className="col-md-10 col-sm-9 col-xs-12 text-left">
            <div className="col-xs-12 filters-container">
              { this.state.channelTagName ? <Tag name={this.state.channelTagName}
                handleTag={component.hideTag} type='channel' /> : null  }
              { this.state.userTagName ? <Tag name={this.state.userTagName}
                handleTag={component.hideTag} type='user' /> : null  }
              { tags }
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
