class Api::V1::DashboardController < ApplicationController
  respond_to :json

  def data_clip
    respond_with User.find(params[:id])
  end

end