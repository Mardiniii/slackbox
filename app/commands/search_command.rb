class SearchCommand < Command

  def self.description
    "Search data in your team's #{Command.integration_name}. The data can contain text or #tags."
  end

  def self.usage
    '`/#{Command.integration_command_name} search [text you want to search or tags]`'
  end

  def self.example
    '`/#{Command.integration_command_name} search admin_password`'
  end

  def response
    if valid?
      { text: search }
    else
      invalid_arguments_response
    end
  end

  def valid?
    !!command_request.text.match(/^search (.*)$/m)
  end

  def parse_data
    if match = command_request.text.match(/^search (.*)$/m)
      value = match.captures.first.gsub(/#\w+/,'')
      tags = command_request.text.scan(/#\w+/).uniq
      { value: value, tags: tags }
    else
      #TODO: create an error for invalid arguments
      raise new Error('Invalid data')
    end
  end

  def search
    parsed_data = parse_data
    value = parsed_data[:value]
    tags = parsed_data[:tags]
    search_text = command_request.text.match(/^search (.*)$/m).captures.first
    data_clips = command_request.team.data_clips.search({name: value, data: value, tags: tags}).limit(5)
    return_string = "Look at the #{data_clips.count} most relevant #{'result'.pluralize(data_clips.count)} :mag::\n"
    data_clips.each do |data_clip|
      return_string << "*#{data_clip.name}*: #{data_clip.data}\n"
    end
    return_string << "\nFollow this awesome url :metal:: #{Rails.application.routes.url_helpers.panel_url(q: search_text)}"
    error_message = "Sometimes you can't find what you except, hopefully I will always be here for you :rainbow:. Try another query."
    data_clips.count > 0 ? return_string : error_message
  end

end
