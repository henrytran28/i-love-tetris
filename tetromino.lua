local Square = require("square")
local colors = require("colors")

local Tetromino = {}

function Tetromino:new(id, origin, color)
    local tetromino = {
        id = id,
        origin = origin,
        color = color
    }
    tetromino.squares = {
        Square:new(0, 0, color),
        Square:new(1, 0, color),
        Square:new(2, 0, color),
        Square:new(3, 0, color)
    }
    self.__index = Tetromino
    setmetatable(tetromino, Tetromino)
    return tetromino
end

function Tetromino:render()
    for _, square in pairs(self.squares) do
        square:render()
    end
end

return Tetromino