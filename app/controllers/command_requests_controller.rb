class CommandRequestsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    command_request = CommandRequest.new command_request_params
    puts command_request.to_yaml
    render json: command_request.response, status: :ok
  end

  private

    def command_request_params
      params.permit(
        :token,:team_id,:team_domain,:channel_id,:channel_name,:user_id,
        :user_name,:command,:text,:response_url
      )
    end

end
