class Command
  attr_accessor :command_request

  def self.register(handler_class,command_name)
    Command.command_handlers[command_name] = handler_class
  end

  def self.command_handlers
    @@command_handlers ||= {}.with_indifferent_access
  end

  def self.handler_for_command(command_name)
    Command.command_handlers[command_name]
  end

  def initialize(command_request)
    self.command_request = command_request
  end

  def invalid_arguments_response
    {
      text: [
        'You made a little mistake :ok_hand: but we still love you :heart:. Give this a shot:',
        self.class.usage,
        'For example:',
        self.class.example
      ].join("\n")
    }
  end

  #TODO: Autoload commands
  register(HelpCommand,:help)
  register(SaveCommand,:save)

end
