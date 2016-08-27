class HandleCommandRequestJob < ActiveJob::Base
  queue_as :default

  def perform(command_request_params)
    command_request = CommandRequest.new command_request_params

    uri = URI.parse(command_request.response_url)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(uri.request_uri)
    request.add_field('Content-Type', 'application/json')
    request.body = command_request.response.to_json

    response = http.request(request)
  end
end
