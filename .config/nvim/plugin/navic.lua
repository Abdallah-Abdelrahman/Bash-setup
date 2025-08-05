local navic = require("nvim-navic")
-- Define a function to integrate navic with airline
function NavicLocation()
    if navic.is_available() then
        return navic.get_location()
    end
    return ""
end

-- Set the airline section to use the custom function
vim.g.airline_section_x = "%{v:lua.NavicLocation()}"
