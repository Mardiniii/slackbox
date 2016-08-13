module PagesHelper
  def slack_oauth_params
    {
      scope: 'commands',
      client_id: '46385812515.46427344132',
      redirect_uri: auth_grant_command_requests_url
    }.to_query
  end
end
