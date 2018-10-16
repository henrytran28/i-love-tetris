local constants = {
    UNIT = 30,
    WINDOW_WIDTH = 510,
    WINDOW_HEIGHT = 600
}

-- function to make table read-only
-- taken from http://lua-users.org/wiki/ReadOnlyTables
function protect(table)
    return setmetatable({}, {
        __index = table,
        __newindex = function(table, key, value)
            error("Attempt to modify read-only table")
        end,
        __metatable = false
    });
end

constants = protect(constants)

return constants
