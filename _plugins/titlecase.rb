# Inspiration:
#   https://github.com/samsouder/titlecase/blob/master/lib/titlecase.rb
# This plugin will convert a string to titlecase
# 
# Usage:
#   title = "how to: a guide to upskilling - 3rd edition"
#   <h1>{{ title | titlecase }}</h1>
# 
# Output:
#   How to: A Guide to Upskilling - 3rd Edition

module Jekyll
  module Titlecase

    def titlecase(input)
      minor_words = %w(a an and as at but by en for if in of on or the to v v. via vs vs.)
      exceptions = %w(: | - . !)
      last_char = ""
      first_word = true

      x = split(input, " ").map do |word|
        is_minor = minor_words.include?(word.gsub(/\W/, "").downcase)
        word_processed = ""

        # this version only looks at the first character
        # capitalize first word
        if first_word
          first_word = false
          word[0] = word[0].capitalize
          word_processed = word
        # if it's a small word preceded by an exception then capitalize it
        elsif is_minor and exceptions.include?(last_char)
          word[0] = word[0].capitalize
          word_processed = word
        # if it's a small word or exception then keep it lowercase
        elsif is_minor or exceptions.include?(word)
          word_processed = word.downcase
        # if any other word then capitalize it
        else
         word[0] = word[0].capitalize
          word_processed = word
        end

        last_char = word[-1, 1]
        word_processed
      end
      x.join(" ")
    end

  end
end

Liquid::Template.register_filter(Jekyll::Titlecase)