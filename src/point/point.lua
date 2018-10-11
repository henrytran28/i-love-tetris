local Point = {}

function Point:new(x, y)
    local point = {x = x, y = y}
    self.__index = self
    setmetatable(point, self)
    return point
end

function sum(p1, p2)
    return Point:new(math.floor(p1.x + p2.x), math.floor(p1.y + p2.y))
end

function diff(p1, p2)
    return Point:new(math.floor(p1.x - p2.x), math.floor(p1.y - p2.y))
end

return Point
