class HelpCommand < Command

  def self.description
    'Show the available commands'
  end

  def response
    { text: message }
  end

  private

    def message
      Command.command_handlers.map do |command_name,handler|
        "`/slackbox #{command_name}`: #{handler.description}"
      end.join("\n")
    end
end
