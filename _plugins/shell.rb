# This plugin executes a shell command
# 
# Usage:
#   input = the command to execute
#   {{ "python run.py" | shell }}

module Shell
  def shell(input)
    input.tr("\\", "")
    `#{input}`
    return ""
  end
end

Liquid::Template.register_filter(Shell)