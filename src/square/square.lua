local constants = require("constants")
local colors = require("colors/colors")

local Square = {}

function Square:new(point, color)
    local square = {
        x = point.x,
        y = point.y,
        color = color
    }
    self.__index = self
    setmetatable(square, self)
    return square
end
function Square:offset(x, y)
    self.x = self.x + x
    self.y = self.y + y
end

function Square:render()
    local unit = constants.UNIT
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", (self.x + 7) * unit,
        constants.WINDOW_HEIGHT - ((self.y + 1) * unit), unit, unit)
    love.graphics.setColor(colors.BLACK)
    love.graphics.rectangle("line", (self.x + 7) * unit,
        constants.WINDOW_HEIGHT - ((self.y + 1) * unit), unit, unit)
end

return Square
