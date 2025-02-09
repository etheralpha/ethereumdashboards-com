# This plugin will convert a section header to an anchor link
# 
# Usage:
#   title = "A Guide to the Universe"
#   <a href="{{ title | anchor }}">{{title}}</a>
# 
# Output:
#   <a href="#a-guide-to-the-universe">A Guide to the Universe</a>

module Jekyll
  module Anchor

    def anchor(input)
      if input.include?("://") or input[0] == "/"
        input
      else
        # remove special characters (they're omitted from anchor tags)
        input.gsub!(/[~!@#$%^&*()+={}\[\]|:;"'<>,.?]/,'')
        # replace all spaces with a dash
        input.gsub!(" ", "-")
        # convert to lowercase
        input.downcase!
        # start with anchor hashtag
        # input.prepend("#")
      end
    end

    def link(link, link_text)
      "[#{link_text}](#{link})"
    end

    def exlink(link, link_text)
      "[#{link_text}](#{link}){:target='blank'}"
    end

  end
end

Liquid::Template.register_filter(Jekyll::Anchor)