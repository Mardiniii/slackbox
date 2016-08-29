class CommandRequestsController < ApplicationController
  protect_from_forgery with: :null_session
  respond_to :json

  def create
    command_request = CommandRequest.new command_request_params
    if command_request.token == ENV['slack_command_token']
      if command_request.handler.async?
        render json: command_request.pre_async_response, status: :ok
        HandleCommandRequestJob.perform_later command_request_params
      else
        render json: command_request.response, status: :ok
      end
    else
      render json: {}, status: 401
    end
  end

  def auth_grant
    uri = URI('https://slack.com/api/oauth.access')
    uri_params = {
      client_id: ENV['slack_client'],
      client_secret: ENV['slack_secret'],
      code: params[:code],
      redirect_uri: auth_grant_command_requests_url
    }
    uri.query = URI.encode_www_form(uri_params)

    res = Net::HTTP.get_response(uri)
    puts "**************************"
    if res.is_a?(Net::HTTPSuccess)
      puts "Success"
      puts res.body
    else
      puts "Fail"
      puts res.body
    end
    puts "**************************"
    redirect_to root_path
  end

  private

    def command_request_params
      params.permit(
        :token,:team_id,:team_domain,:channel_id,:channel_name,:user_id,
        :user_name,:command,:text,:response_url
      )
    end

end
