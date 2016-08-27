class SearchCommand < Command

  def self.async?
    true
  end

  def self.command_regex
    /^search (?<query>.*)$/m
  end

  def self.description
    "Search data in your team's #{Command.integration_name}. The data can contain text or #tags."
  end

  def self.usage
    "`/#{Command.integration_command_name} search [text you want to search or tags]`"
  end

  def self.example
    "`/#{Command.integration_command_name} search admin password`"
  end

  def response
    if valid?
      data_clips = search
      if data_clips.count > 0
        text = ":mag: Look at the #{data_clips.count} most relevant #{'result'.pluralize(data_clips.count)} for the query `#{parse_data[:query]}`:"
        # Example:
        # https://api.slack.com/docs/messages/builder?msg=%7B%22attachments%22%3A%5B%7B%22fallback%22%3A%22New%20dataclip%20created%20by%20Simon%22%2C%22color%22%3A%22%2336a64f%22%2C%22pretext%22%3A%22New%20dataclip%22%2C%22author_name%22%3A%22Simon%22%2C%22title%22%3A%22El%20titulo%20del%20dataclip%22%2C%22text%22%3A%22el%20contenido%20del%20dataclip%20%3Chttps%3A%2F%2Fasdfasf%7C%23asdf%3E%22%2C%22fields%22%3A%5B%7B%22title%22%3A%22Priority%22%2C%22value%22%3A%22High%22%2C%22short%22%3Afalse%7D%5D%2C%22footer%22%3A%22SlashBox%22%2C%22ts%22%3A1472323984%7D%5D%7D
        {
          text: text,
          mrkdwn_in: ["text"],
          attachments: data_clips.map do |data_clip|
            {
              fallback: "*#{data_clip.name}* => #{data_clip.data}",
              color: '#36a64f',
              title: data_clip.starred ? ":star: #{data_clip.name}" : data_clip.name,
              text: data_clip.data,
              mrkdwn_in: ["text"]
            }
          end.push({
            fallback: "More results: #{search_url}",
            text: ":metal: Follow <#{search_url}|this awesome link> to see the results in the SlashBox dashboard"
          })
        }
      else
        {
          text: "Sometimes you can't find what you except, hopefully I will always be here for you :rainbow:. Try another query."
        }
      end
    else
      invalid_arguments_response
    end
  end

  def valid?
    !!command_request.text.match(self.class.command_regex)
  end

  def search_url
    Rails.application.routes.url_helpers.panel_url(q: parse_data[:query])
  end

  def parse_data
    if match = command_request.text.match(self.class.command_regex)
      value = match.captures.first.gsub(/#\w+/,'')
      tags = command_request.text.scan(/#\w+/).uniq
      { value: value, tags: tags, query: match[:query] }
    else
      #TODO: create an error for invalid arguments
      raise new Error('Invalid data')
    end
  end

  def search
    parsed_data = parse_data
    value = parsed_data[:value]
    tags = parsed_data[:tags]
    search_text = command_request.text.match(self.class.command_regex).captures.first
    command_request
      .team
      .data_clips
      .search({
        name: value,
        data: value,
        tags: tags
      })
      .limit(5)
  end

end
