class DashboardController < WebController
  before_action :authenticate_user!

  def panel
    @user = current_user
    @team = @user.team
    @channels = @team.channels
    @users = @team.users
    @tags = @team.tags
    @data_clips = @team.data_clips.search({ q: params[:q] })
  end

  def show
    @data_clip = current_user.team.data_clips.find(params[:id])
  end

end
