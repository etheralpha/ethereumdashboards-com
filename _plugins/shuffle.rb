# This plugin will shuffle the input array into a random order
# 
# Usage:
#   {{ my_collection | shuffle }}

module Jekyll
  module Shuffle

    def shuffle(input)
      input.shuffle
    end

  end
end

Liquid::Template.register_filter(Jekyll::Shuffle)