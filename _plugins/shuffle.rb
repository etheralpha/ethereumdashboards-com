# https://github.com/pathawks/liquid-md5/blob/master/lib/liquid-md5.rb
# This plugin randomizes/shuffles arrays
# 
# Usage:
#   input = array to shuffle
#   {{ site.data.people | shuffle }}

module Shuffle
  def shuffle(input)
    input.shuffle
  end
end

Liquid::Template.register_filter(Shuffle)