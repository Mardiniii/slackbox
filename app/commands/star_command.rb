class StarCommand < Command
  COMMAND_REGEX = /^star +(\w+) (.*)$/m

  def self.description
    "Save starred data in your team's slackbox. The data can contain text, URLs and tags."
  end

  def self.usage
    '`/slackbox star [data clip name] [some text that can contain text, URLs and tags]`'
  end

  def self.example
    '`/slackbox star admin_password 12345678 #password #secret`'
  end

  def response
    if valid?
      save
      { text: 'Your data clip has been saved' }
    else
      invalid_arguments_response
    end
  end

  def valid?
    !!command_request.text.match(COMMAND_REGEX)
  end

  def parse_data
    if match = command_request.text.match(COMMAND_REGEX)
      name, value = match.captures
      { name: name, value: value }
    else
      #TODO: create an error for invalid arguments
      raise new Error('Invalid data')
    end
  end

  def save
    parsed_data = parse_data
    name = parsed_data[:name]
    value = parsed_data[:value]

    data_clip = DataClip.create!(
      name: name,
      data: value,
      starred: true,
      has_urls: value.match(URI::regexp(%w(http https))),
      user_id: command_request.user.id,
      channel_id: command_request.channel.id,
      team_id: command_request.team.id,
      slack_response: command_request.to_hash,
    )
    tags = value.scan(/#\w+/).uniq
    tags.each do |tag|
      data_clip.tags << command_request.team.tags.where(name: tag).first_or_create
    end

  end

end