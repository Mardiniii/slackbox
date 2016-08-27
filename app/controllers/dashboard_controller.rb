class DashboardController < WebController
  before_action :authenticate_user!

  def panel
    @user = current_user
    @team = @user.team
    @channels = @team.channels
    @users = @team.users
    @tags = @team.tags

    if params[:starred]
      @data_clips = @team.data_clips.starred
    else
      @data_clips = @team.data_clips
    end
    @data_clips = @data_clips.search({ q: params[:q] })
  end

  def show
    @data_clip = current_user.team.data_clips.find(params[:id])
  end

end
