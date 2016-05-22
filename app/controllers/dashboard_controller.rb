class DashboardController < ApplicationController
  before_action :authenticate_user!

  def panel
    @user = current_user
    @team = @user.team
    @channels = @team.channels
    @members = @team.users
    @tags = @team.tags
    @data_clips = @team.data_clips
  end

  def show
    @data_clip = current_user.team.data_clips.find(params[:id])
  end

end
