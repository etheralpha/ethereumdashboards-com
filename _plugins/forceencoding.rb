# This plugin will force encode to 8bit
# 
# Usage:
#   {{ content | force_encode }}

module Jekyll
  module ForceEncode

    def forceencode(input)
      input.force_encoding('UTF-8')
    end

  end
end

Liquid::Template.register_filter(Jekyll::ForceEncode)