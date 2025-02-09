# This plugin will wrap the content in the specified tag and and apply the specified classes
# 
# Usage 1:
#   title = "A Guide to the Universe"
#   {{ title | wrap: "h1", "title text-black" }}
# 
# Output 1:
#   <h1 class='title text-black'>A Guide to the Universe</h1>
# 
# 
# Usage 2:
#   {{ title | wrap: "em" | wrap: "h1", "text-black" }}
# 
# Output 2:
#   <h1 class='text-black'><em>A Guide to the Universe</em></h1>

module Jekyll
  module Wrap

    def wrap(input, tag, classes=nil)
      if classes
        "<#{tag} class='#{classes}'>#{input}</#{tag}>"
      else
        "<#{tag}>#{input}</#{tag}>" 
      end 
    end

  end
end

Liquid::Template.register_filter(Jekyll::Wrap)