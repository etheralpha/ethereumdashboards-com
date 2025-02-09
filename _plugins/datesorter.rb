# This plugin will sort a collection by date
# 
# Usage:
#   collection = A data collection
#   key = the key name for the date in the collection
#   date_format = the current date format: https://strftime.net/
# 
#   {{ site.data.people | date_sort: "birthday", "%d - %m - %Y" }}

require 'date'

module Jekyll
  module DateSorter
    def date_sort(collection, key, date_format)
      if collection[0]
        collection.sort_by do |el|
          Date.parse(el[key], date_format)
        end
      else
        # only one item in collection
        collection
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::DateSorter)