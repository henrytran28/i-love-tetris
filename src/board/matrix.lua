local Square = require("square/square")
local Point = require("point/point")

local Matrix = {}

function Matrix:new(width, height)
    local matrix = {
        height = height,
        width = width
    }
    for x = 0, width - 1 do
        matrix[x] = {}
        for y = 0, height - 1 do
            matrix[x][y] = 0
        end
    end
    self.__index = self
    setmetatable(matrix, self)
    return matrix
end

function Matrix:fill(x, y, color)
    self[x][y] = color
end

function Matrix:unfill(x, y)
    self[x][y] = 0
end

function Matrix:isFilled(x, y)
    return self[x][y] ~= 0
end

function Matrix:getFilledIndices()
    filledIndices = {}
    for y = 0, self.height - 1 do
        filled = true
        for x = 0, self.width - 1 do
            if not self:isFilled(x, y) then
                filled = false
            end
        end
        if filled then
            table.insert(filledIndices, y)
        end
    end
    return filledIndices
end

function Matrix:print()
    for y = #self[1], 0, -1 do
        for x = 0, #self do
            local value = 0
            if self[x][y] ~= 0 then value = 1 end
            io.write(value .. " ")
        end
        io.write("\n")
    end
    print()
end

function Matrix:render()
    for y = 0, #self[1] do
        for x = 0, #self do
            if self[x][y] ~= 0 then
                Square:new(Point:new(x, y), self[x][y]):render()
            end
        end
    end
end

return Matrix
