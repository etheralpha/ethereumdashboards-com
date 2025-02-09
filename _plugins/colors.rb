# This plugin will change the text to the specified color
# 
# Usage 1:
#   title = "A Guide to the Universe"
#   {{ title | color: "#333" }}
# 
# Output 1:
#   <span style='color:#333;'>A Guide to the Universe</span>
# 
# 
# Usage 2:
#   title = "A Guide to the Universe"
#   {{ title | red }}
# 
# Output 2:
#   <span class='text-danger'>A Guide to the Universe</span>

module Jekyll
  module Colors

    def color(input, color)
      "<span style='color:#{color};'>#{input}</span>"
    end

    def green(input)
      "<span class='text-success'>#{input}</span>"
    end

    def success(input, opacity=nil)
      opacity = opacity ? "text-opacity-#{opacity}" : ""
      "<span class='text-success #{opacity}'>#{input}</span>"
    end

    def yellow(input)
      "<span class='text-warning'>#{input}</span>"
    end

    def warning(input)
      "<span class='text-warning'>#{input}</span>"
    end

    def red(input)
      "<span class='text-danger'>#{input}</span>"
    end

    def danger(input)
      "<span class='text-danger'>#{input}</span>"
    end

    def grey(input)
      "<span class='text-muted'>#{input}</span>"
    end

    def gray(input)
      "<span class='text-muted'>#{input}</span>"
    end

    def muted(input)
      "<span class='text-muted'>#{input}</span>"
    end

    def blue(input)
      "<span class='text-primary'>#{input}</span>"
    end

    def primary(input)
      "<span class='text-primary'>#{input}</span>"
    end

    def lightblue(input)
      "<span class='text-info'>#{input}</span>"
    end

    def info(input)
      "<span class='text-info'>#{input}</span>"
    end

    def white(input)
      "<span class='text-light'>#{input}</span>"
    end

    def light(input)
      "<span class='text-light'>#{input}</span>"
    end

    def black(input)
      "<span class='text-dark'>#{input}</span>"
    end

    def dark(input)
      "<span class='text-dark'>#{input}</span>"
    end

  end
end


Liquid::Template.register_filter(Jekyll::Colors)