local Point = {}

function Point:new(x, y)
    local point = {x = x, y = y}
    self.__index = Point
    setmetatable(point, new)
    return point
end

function sum(p1, p2)
    return Point:new(p1.x + p2.x, p1.y + p2.y)
end

function diff(p1, p2)
    return Point:new(p1.x - p2.x, p1.y - p2.y)
end

return Point
