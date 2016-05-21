class SaveCommand < Command

  def response
    save
    { text: 'Your data clip has been saved' }
  end

  def self.description
    "Save data in your team's slackbox. The data can be text or some URL."
  end

  def parse_data
    if match = command_request.text.match(/^save +(\w+) (.*)$/)
      name, value = match.captures
      { name: name, value: value }
    else
      #TODO the command is not valid
    end
  end

  def save
    parsed_data = parse_data
    name = parsed_data[:name]
    value = parsed_data[:value]

    data_clip = DataClip.create!(
      name: name,
      data: value,
      starred: false,
      has_urls: value.match(URI::regexp(%w(http https))),
      user_id: command_request.user.id,
      channel_id: command_request.channel.id,
      slack_response: command_request.to_hash,
    )
    tags = value.scan(/#\w+/).uniq
    tags.each do |tag|
      data_clip.tags << command_request.team.tags.where(name: tag).first_or_create
    end

  end

end
