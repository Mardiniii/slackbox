class StarredCommand < SearchCommand

  def self.command_regex
    /^starred (?<query>.*)$/m
  end

  def self.description
    "Search starred data in your team's #{Command.integration_name}. The query can contain text or #tags."
  end

  def self.usage
    "`/#{Command.integration_command_name} starred [text you want to search or tags]`"
  end

  def self.example
    "`/#{Command.integration_command_name} starred admin password`"
  end

  def search_url
    Rails.application.routes.url_helpers.panel_url(q: parse_data[:query],starred: 'starred')
  end

  def search
    parsed_data = parse_data
    value = parsed_data[:value]
    tags = parsed_data[:tags]
    search_text = command_request.text.match(self.class.command_regex).captures.first
    command_request
      .team
      .data_clips
      .starred
      .search({
        name: value,
        data: value,
        tags: tags
      })
      .limit(5)
  end

end
