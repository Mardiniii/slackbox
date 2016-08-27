class StarCommand < Command
  COMMAND_REGEX = /^star\s+(?<name>.+?)\s*=>\s*(?<value>.+)$/m

  def self.description
    "Save starred data in your team's #{Command.integration_name}. The data can contain text, URLs and tags."
  end

  def self.usage
    "`/#{Command.integration_command_name} star [data clip name] => [some text that can contain text, URLs and tags]`"
  end

  def self.example
    "`/#{Command.integration_command_name} star admin password => 12345678 #password #secret`"
  end

  def response
    if valid?
      data_clip = save
      # Example:
      # https://api.slack.com/docs/messages/builder?msg=%7B%22attachments%22%3A%5B%7B%22fallback%22%3A%22New%20dataclip%20created%20by%20Simon%22%2C%22color%22%3A%22%2336a64f%22%2C%22pretext%22%3A%22New%20dataclip%22%2C%22author_name%22%3A%22Simon%22%2C%22title%22%3A%22El%20titulo%20del%20dataclip%22%2C%22text%22%3A%22el%20contenido%20del%20dataclip%20%3Chttps%3A%2F%2Fasdfasf%7C%23asdf%3E%22%2C%22fields%22%3A%5B%7B%22title%22%3A%22Priority%22%2C%22value%22%3A%22High%22%2C%22short%22%3Afalse%7D%5D%2C%22footer%22%3A%22SlashBox%22%2C%22ts%22%3A1472323984%7D%5D%7D
      {
        response_type: 'in_channel',
        attachments: [
          {
              fallback: "New starred dataclip created by #{data_clip.user.username}",
              color: "#36a64f",
              pretext: "New starred dataclip created by @#{data_clip.user.username}",
              title: ":star: #{data_clip.name}",
              text: data_clip.data,
              footer: "SlashBox",
              ts: data_clip.created_at.to_time.to_i,
              mrkdwn_in: ["text"]
          },
        ]
      }
    else
      invalid_arguments_response
    end
  end

  def valid?
    !!command_request.text.match(COMMAND_REGEX)
  end

  def parse_data
    if match = command_request.text.match(COMMAND_REGEX)
      match
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
    data_clip
  end

end
