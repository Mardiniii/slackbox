class DashboardController < ApplicationController
  before_action :authenticate_user!

  def panel
    @user = current_user
    @data_clips = @user.data_clips
  end
end
