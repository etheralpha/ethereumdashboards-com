# This plugin will add commas to large number
# 
# Usage:
#   value = 123456
#   {{ value | formatnumber }}
# 
# Output:
#   123,456

module Jekyll
  module FormatNumber

    def formatnumber(input)
      input.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    end
  end
end

Liquid::Template.register_filter(Jekyll::FormatNumber)