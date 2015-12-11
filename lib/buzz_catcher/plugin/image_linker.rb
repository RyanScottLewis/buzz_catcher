require "yaml"
require "cinch/plugin"

class BuzzCatcher::Plugin::ImageLinker
  include Cinch::Plugin

  match /([a-z]+)\.(bmp|jpeg|jpg|gif)/i, method: :respond, use_prefix: false
  match /images/i, method: :list

  def initialize(bot)
    super

    data_path = BuzzCatcher.root.join("data", "images.yml")
    @images = YAML.load_file(data_path)
  end

  def respond(message, file_name, _file_extension)
    file_name = file_name.downcase.strip
    result = @images.find { |entry| entry["matches"].include?(file_name) }

    return if result.nil?

    url = result["urls"].sample

    message.reply(url)
  end

  def list(message)
    message.user.send(match_list)
  end

  protected

  def match_list
    @images.collect { |item| "#{item['matches'].join(',')}" }.join(" ")
  end
end
