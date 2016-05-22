class HelpCommand < Command

  def self.description
    'Show the available commands'
  end

  def self.usage
    '`/slackbox help`'
  end

  def self.example
    usage
  end


  def response
    { text: message }
  end

  def valid?
    'help' == command_request.sub_command
  end

  private

    def message
      Command.command_handlers.map do |command_name,handler|
        "* `/slackbox #{command_name}`: #{handler.description}"
      end.join("\n")
    end
end
