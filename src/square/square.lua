local constants = require("constants")

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
    local height = constants.HEIGHT - 2
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.x * unit, height * unit - ((self.y + 1) * unit), unit, unit)
    love.graphics.setColor({0.8 * self.color[1], 0.8 * self.color[2], 0.8 * self.color[3]})
    love.graphics.rectangle("line", self.x * unit, height * unit - ((self.y + 1) * unit), unit, unit)
end

return Square
