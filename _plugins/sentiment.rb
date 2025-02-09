# This plugin will convert sentiment to a symbol
# 
# Usage:
#   protocol.permissionless.sentiment = "good"
#   <span>{{protocol.permissionless.sentiment | symbol}}</span>
# 
# Output:
#   <span>✅</span>

module Jekyll
  module Sentiment

    def symbol(input)
      if input == "good"
        # "✅"
        "<img src='/assets/img/symbols/symbol-good.png'/>"
      elsif input == "warning"
        # "⚠️"
        "<img src='/assets/img/symbols/symbol-warning.png'/>"
      elsif input == "bad"
        # "❌"
        "<img src='/assets/img/symbols/symbol-bad.png'/>"
      elsif input == "n/a"
        "N/A"
      else
        "-"
      end
    end

  end
end

Liquid::Template.register_filter(Jekyll::Sentiment)