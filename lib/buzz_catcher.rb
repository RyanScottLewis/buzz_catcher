require "pathname"

require "cinch"
require "cinch/plugins/identify"

module BuzzCatcher
  class << self
    def root
      @root ||= Pathname.new(__FILE__).join("..", "..").expand_path
    end

    def instance
      @instance ||= Cinch::Bot.new do
        configure do |config|
          config.nick     = "BuzzCatcher"
          config.realname = config.nick
          config.user     = config.nick

          config.messages_per_second = 5
          config.modes = ["B"]

          config.server   = "irc.snoonet.org"
          config.channels = ["#DissonantGuile", "##arecipeforawesome", "##bogans"]

          config.plugins.prefix = /^\./

          config.plugins.plugins = [Cinch::Plugins::Identify, Plugin::InviteAcceptor, Plugin::ImageLinker, Plugin::WingWhacker, Plugin::Pizza]

          config.plugins.options[Cinch::Plugins::Identify] = { username: config.nick, password: "B5u7Z1z1", type: :nickserv }
        end
      end
    end

    def start
      instance.start
    end
  end
end

module BuzzCatcher::Plugin; end

require "buzz_catcher/plugin/invite_acceptor"
require "buzz_catcher/plugin/image_linker"
require "buzz_catcher/plugin/wing_whacker"
require "buzz_catcher/plugin/pizza"
