class CommandRequest

  attr_accessor :token,:team_id,:team_domain,:channel_id,:channel_name,:user_id,
                :user_name,:command,:text,:response_url,
                :handler, :team, :user, :channel

  def initialize(opts)
    opts.each do |field,val|
      send("#{field}=",val) if respond_to? "#{field}="
    end
    prepare
  end

  def response
    handler = Command.handler_for_command(sub_command) || Command.handler_for_command(:help)
    handler.new(self).response
  end

  def sub_command
    text.split(' ').first
  end

  def prepare
    if self.team = Team.find_by_slack_id(team_id)
      self.team.update!(domain: team_domain)
    else
      self.team = Team.create!(slack_id: team_id,domain: team_domain)
    end

    if self.channel = self.team.channels.find_by_slack_id(channel_id)
      self.channel.update!(name: channel_name)
    else
      self.channel = self.team.channels.create!(slack_id: channel_id,name: channel_name)
    end

    if self.user = self.team.users.find_by_slack_id(user_id)
      self.user.update!(username: user_name)
    else
      self.user = self.team.users.create!(slack_id: user_id,username: user_name)
    end

  end

  def to_hash
    instance_values.slice(
      :token,:team_id,:team_domain,:channel_id,:channel_name,:user_id,
      :user_name,:command,:text,:response_url
    )
  end

end
