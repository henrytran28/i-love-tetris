local Square = {}

function Square:new(x, y, color)
    local square = {
        x = x, 
        y = y, 
        color = color
    }
    self.__index = Square
    setmetatable(square, Square)
    return square
end

function Square:offset(x, y)
    self.x = self.x + (x * unit)
    self.y = self.y + (y * unit)
end

function Square:render()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.x * unit, height - ((self.y + 1) * unit), unit, unit)
    love.graphics.setColor({0.8 * self.color[1], 0.8 * self.color[2], 0.8 * self.color[3]})
    love.graphics.rectangle("line", self.x * unit, height - ((self.y + 1) * unit), unit, unit)
end

return Square