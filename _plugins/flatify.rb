# Reference:
#   http://acegik.net/blog/ruby/jekyll/plugins/howto-nest-liquid-template-variables-inside-yaml-front-matter-block.html
# 
# Usage:
#   ---
#   layout: post
#   caption: "Introduction to {{ site.title }}"
#   ---
# 
#   <h1>{{ page.caption | flatify }}</h1>

module Jekyll
  module Flatify

    def flatify(input)
      Liquid::Template.parse(input).render(@context)
    end
  end
end

Liquid::Template.register_filter(Jekyll::Flatify)