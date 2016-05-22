class DashboardController < ApplicationController
  before_action :authenticate_user!

  def panel
    @user = current_user
    @team = @user.team
    @data_clips = @team.data_clips
  end
end
