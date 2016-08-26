class NewPanelController < ApplicationController
  def index
    @hello_world_props = { name: "Stranger" }
    @user = current_user
    @team = @user.team
    @channels = @team.channels
    @users = @team.users
    @tags = @team.tags
    @dataclips = @team.data_clips.search({ q: params[:q] })
  end
end
