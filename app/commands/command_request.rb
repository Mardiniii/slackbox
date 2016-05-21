class CommandRequest

  attr_accessor :token,:team_id,:team_domain,:channel_id,:channel_name,:user_id,
                :user_name,:command,:text,:response_url, :handler

  def initialize(opts)
    opts.each do |field,val|
      send("#{field}=",val) if respond_to? "#{field}="
    end
  end

  def response
    handler = Command.handler_for_command(sub_command) || Command.handler_for_command(:help)
    handler.new(self).response
  end

  def sub_command
    text.split(' ').first
  end

end
