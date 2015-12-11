require "cinch/plugin"

class BuzzCatcher::Plugin::WingWhacker
  SWEARS = ["shit", "fuck", "hell", "everliving bajesus", "sin"]

  include Cinch::Plugin

  match /(?:wingwhack|ww) (.+)/i

  def execute(message, user)
    response = rand(3) == 0 ? "wing whacks the #{SWEARS.sample} out of #{user}" : "wing whacks #{user}"

    message.action_reply(response)
  end
end
