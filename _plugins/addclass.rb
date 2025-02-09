# This plugin will assign the specified classes
# 
# Usage:
#   title = "A Guide to the Universe"
#   {{ title | addclass: "title text-black" }}
# 
# Output:
#   <span class='title text-black'>A Guide to the Universe</span>

module Jekyll
  module AddClass

    def addclass(input, classes=nil)
      "<span class='#{classes}'>#{input}</span>"
    end

  end
end


Liquid::Template.register_filter(Jekyll::AddClass)