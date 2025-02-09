# This plugin will add a tooltip
# 
# Usage 1:
#   <h1>A Guide to the {{"Spelunking" | tooltip: site.data.tooltips.spelunking}}</h1>
# Usage 2:
#   <h1>A Guide to the {{"Spelunking" | tooltip: "The exploration of caves, especially as a hobby"}}</h1>
# Usage 3:
#   <h1>A Guide to the Spelunking {{"" | tooltip: "The exploration of caves, especially as a hobby"}}</h1>
# 
# Output: 
#   <h1>
#     A Guide to the Spelunking
#     <span data-bs-toggle='tooltip' data-bs-placement='top' title='The exploration of caves, especially as a hobby'>
#       <svg xmlns='http://www.w3.org/2000/svg' style='width:0.8em; height:auto; margin-top:-0.75rem' fill='currentColor' class='bi bi-info-circle' viewBox='0 0 16 16'>
#         <path d='M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z'/>
#         <path d='m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z'/>
#       </svg>
#     </span>
#   </h1>

module Jekyll
  module Tooltip

    def tooltip(input, msg)
      if input == ""
        input = "<svg xmlns='http://www.w3.org/2000/svg' style='width:0.8rem; height:auto; margin-top:-0.75rem' fill='currentColor' class='bi bi-info-circle' viewBox='0 0 16 16'><path d='M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z'/><path d='m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z'/></svg>"
      end
      if msg != nil
        "<span data-bs-toggle='tooltip' data-bs-title='#{msg}'>#{input}</span"
      else
        input
      end
    end

  end
end

Liquid::Template.register_filter(Jekyll::Tooltip)