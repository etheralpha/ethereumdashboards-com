# This plugin prints the input to the command line
# 
# Usage:
#   input = what you want to print/inspect
#   {{ variable | print }}

module Print
  def print(input)
    puts input
  end
end

Liquid::Template.register_filter(Print)