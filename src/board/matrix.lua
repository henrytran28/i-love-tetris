local Matrix = {}

function Matrix:new(width, height)
    local matrix = {
        height = height,
        width = width
    }
    for i = 0, width - 1 do
        matrix[i] = {}
        for j = 0, height - 1 do
            matrix[i][j] = 0
        end
    end
    self.__index = self
    setmetatable(matrix, self)
    return matrix
end

function Matrix:fill(x, y)
    self[x][y] = 1
end

function Matrix:unfill(x, y)
    self[x][y] = 0
end

function Matrix:isFilled(x, y)
    return self[x][y] == 1
end

function Matrix:getFilledIndices()
    filledIndices = {}
    for j = 0, self.height - 1 do
        filled = true
        for i = 0, self.width - 1 do
            if not self:isFilled(i, j) then
                filled = false
            end
        end
        if filled then
            table.insert(filledIndices, j)
        end
    end
    return filledIndices
end

function Matrix:clear()
    for i = 0, #self do
        for j = 0, #self[i] do
            self[i][j] = 0
        end
    end
end

function Matrix:print()
    for j = #self[1], 0, -1 do
        for i = 0, #self do
            io.write(self[i][j] .. " ")
        end
        io.write("\n")
    end
    print()
end

return Matrix
