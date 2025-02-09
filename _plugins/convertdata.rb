# This plugin will convert data between XML, JSON, and YAML
# 
# Usage:
#   input = A data collection
#   {{ site.data.people | yamltojson }}

require 'active_support/core_ext/hash'
require 'json'
require 'yaml'

module Jekyll
  module ConvertData

    def xmltojson(input)
      JSON.load(Hash.from_xml(input).to_json)
    end

    def xmltoyaml(input)
      YAML.load(Hash.from_xml(input).to_yaml)
    end

    def jsontoyaml(input)
      YAML.load(input.to_yaml)
    end

    def jsontoxml(input)
      abort("ERROR: jsontoxml() not available")
    end

    def yamltojson(input)
      JSON.load(input.to_json)
    end

    def yamltoxml(input)
      abort("ERROR: yamltoxml() not available")
    end

  end
end


Liquid::Template.register_filter(Jekyll::ConvertData)