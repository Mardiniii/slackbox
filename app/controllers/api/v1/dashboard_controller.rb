class Api::V1::DashboardController < ApplicationController
  respond_to :json

  before_action :authenticate_with_token!

  def data_clip
    respond_with api_current_user.team.data_clips.find(params[:id])
  end

  def panel
    channel_info = ChannelInfo.new(api_current_user)
    respond_with channel_info
  end

end