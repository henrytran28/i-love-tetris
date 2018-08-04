local Point = {}

function Point:new(x, y)
    local point = {x = x, y = y}
    self.__index = self
    setmetatable(point, Point)
    return point
end

function Point:add(point)
    self.x = self.x + point.x
    self.y = self.y + point.y
end

function Point:subtract(point)
    self.x = self.x - point.x
    self.y = self.y - point.y
end

return Point