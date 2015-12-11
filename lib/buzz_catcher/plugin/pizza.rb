require "cinch/plugin"

class BuzzCatcher::Plugin::Pizza
  include Cinch::Plugin

  match /pizza (.+)/i

  def initialize(bot)
    super

    data_path = BuzzCatcher.root.join("data", "pizza_toppings.yml")
    @toppings = YAML.load_file(data_path)
  end

  def execute(message, user)
    topping_count = rand(5) + 1
    toppings = @toppings.sample(topping_count)
    response = "makes #{user} a pizza topped with #{to_sentence(toppings)}"

    message.action_reply(response)
  end

  protected

  def to_sentence(words, options={})
    default_connectors = {
      words_connector: ", ",
      two_words_connector: " and ",
      last_word_connector: ", and "
    }
    options = default_connectors.merge!(options)

    case words.length
      when 0 then ""
      when 1 then words[0].to_s.dup
      when 2 then "#{words[0]}#{options[:two_words_connector]}#{words[1]}"
      else
        "#{words[0...-1].join(options[:words_connector])}#{options[:last_word_connector]}#{words[-1]}"
    end
  end
end
