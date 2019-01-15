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

function Matrix:reset()
    for x = 0, self.width - 1 do
        for y = 0, self.height - 1 do
            self:unfill(x, y)
        end
    end
end

function Matrix:isFilled(x, y)
    if x >= self.width or x < 0 or y >= self.height or y < 0 then
        return false
    end
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
    for y = self.height, 0, -1 do
        for x = 0, self.width do
            if self:isFilled(x, y) then
                io.write(1 .. " ")
            else
                io.write(0 .. " ")
            end
        end
        io.write("\n")
    end
    print()
end

function Matrix:render()
    for y = 0, self.height do
        for x = 0, self.width do
            if self:isFilled(x, y) then
                Square:new(Point:new(x, y), self[x][y]):render()
            end
        end
    end
end

return Matrix
