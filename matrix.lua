local Matrix = {}

function Matrix:new(width, height)
    local matrix = {}
    for i = 0, width - 1 do
        matrix[i] = {}
        for j = 0, height - 1 do
            matrix[i][j] = 0
        end
    end
    self.__index = Matrix
    setmetatable(matrix, Matrix)
    return matrix
end

function Matrix:fill(x, y)
    self[x][y] = 1
end

function Matrix:unfill(x, y)
    self[x][y] = 0
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
end

return Matrix