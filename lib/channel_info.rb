class ChannelInfo

  attr_accessor :user, :team, :channels, :users, :tags, :data_clips

  def initialize(user)
    @user = user
    @team = @user.team
    @channels = @team.channels
    @users = @team.users
    @tags = @team.tags
    @data_clips = @team.data_clips
  end
end