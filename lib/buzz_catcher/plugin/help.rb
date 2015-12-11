require "cinch/plugin"

class BuzzCatcher::Plugin::Help
  include Cinch::Plugin

  match /help\b(.+)?/i

  def execute(message, command)
    response = command.nil? ? list : help_for_command(command)

    message.user.send(response)
  end

  protected

  def list
  end

  def help_for_command(command)
  end
end
