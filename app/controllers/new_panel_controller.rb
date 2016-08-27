class NewPanelController < ApplicationController
  def index
    @user = current_user
    @team = @user.team
    @channels = @team.channels
    @users = @team.users
    @tags = @team.tags
    @dataclips = @team.data_clips.search({ q: params[:q] })
  end
end
