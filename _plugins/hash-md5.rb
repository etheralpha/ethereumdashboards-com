# https://github.com/pathawks/liquid-md5/blob/master/lib/liquid-md5.rb
# This plugin creates an MD5 hash
# 
# Usage:
#   input = data to hash
#   {{ site.data.people | md5 }}
# 
# Output:
#   d7d563ded561db4cc7f98f107d231c3a

require 'digest/md5'

module MDhash
  def md5(input)
    Digest::MD5.hexdigest input.strip
  end
end

Liquid::Template.register_filter(MDhash)