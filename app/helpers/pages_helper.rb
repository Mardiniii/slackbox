module PagesHelper
  def slack_oauth_params
    {
      scope: 'commands',
      client_id: "#{ENV['slack_client']}",
      redirect_uri: auth_grant_command_requests_url
    }.to_query
  end
end
