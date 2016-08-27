class HelpCommand < Command

  def self.async?
    false
  end

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
    {
      attachments: Command.command_handlers.map do |command_name,handler|
        {
          fallback: "`/#{Command.integration_command_name} #{command_name}`: #{handler.description}",
          color: "#36a64f",
          title: "/box #{command_name}",
          text: [
            handler.description,
            "example: #{handler.example}",
          ].join("\n"),
          mrkdwn_in: ["text"]
        }
      end
    }
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
