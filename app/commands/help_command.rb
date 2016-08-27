class HelpCommand < Command

  def self.description
    'Show the available commands'
  end

  def self.usage
  "`/#{Command.integration_command_name} help`"
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
        "* `/#{Command.integration_command_name} #{command_name}`: #{handler.description}"
      end.join("\n")
    end
end
