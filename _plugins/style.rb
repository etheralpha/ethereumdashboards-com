# This plugin will change the text to the specified style
# 
# Usage 1:
#   title = "A Guide to the Universe"
#   {{ title | weight: "300" }}
# 
# Output 1:
#   <span style='font-weight:300;'>A Guide to the Universe</span>
# 
# 
# Usage 2:
#   {{ title | bold }}
# 
# Output 2:
#   <span class='fw-bold'>A Guide to the Universe</span>

module Jekyll
  module Style

    def weight(input, weight)
      "<span style='font-weight:#{weight};'>#{input}</span>"
    end

    def bold(input)
      "<span class='fw-bold'>#{input}</span>"
    end

    def bolder(input)
      "<span class='fw-bolder'>#{input}</span>"
    end

    def semibold(input)
      "<span class='fw-semibold'>#{input}</span>"
    end

    def normal(input)
      "<span class='fw-normal'>#{input}</span>"
    end

    def light(input)
      "<span class='fw-light'>#{input}</span>"
    end

    def lighter(input)
      "<span class='fw-lighter'>#{input}</span>"
    end

    def italic(input)
      "<span class='fst-italic'>#{input}</span>"
    end

    def small(input)
      "<small>#{input}</small>"
    end

    def opacity(input, opacity)
      "<span class='opacity-#{opacity}'>#{input}</span>"
    end

  end
end

Liquid::Template.register_filter(Jekyll::Style)