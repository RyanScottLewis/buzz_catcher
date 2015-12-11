require "cinch/plugin"

class BuzzCatcher::Plugin::InviteAcceptor
  include Cinch::Plugin

  listen_to :invite, method: :join_on_invite

  def join_on_invite(message)
    bot.join(message.channel)
  end
end
