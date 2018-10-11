local Square = require("square")
local Point = require("point")
local colors = require("colors")
local properties = require("properties")
local rotationState = require("rotation_state")

local Tetromino = {}

function Tetromino:new(id, origin, color)
    local tetromino = {
        id = id,
        origin = origin,
        color = color,
        squares = {},
        rotationState = rotationState:new()
    }
    for _, value in pairs(properties.LAYOUTS[id]) do
        table.insert(tetromino.squares, Square:new(sum(origin, value), color))
    end
    self.__index = self
    setmetatable(tetromino, self)
    return tetromino
end

function Tetromino:offset(x, y)
    self.origin = sum(self.origin, Point:new(x, y))
    for _, square in pairs(self.squares) do
        square:offset(x, y)
    end
end

function Tetromino:rotateCw()
    absRotationPoint = sum(self.origin, properties.ROTATION_POINTS[self.id])
    for i, square in pairs(self.squares) do
        currentSquare = diff(Point:new(square.x, square.y), absRotationPoint)
        btmRight = sum(currentSquare, Point:new(1, 0))
        newPoint = sum(Point:new(btmRight.y, -btmRight.x), absRotationPoint)
        self.squares[i] = Square:new(newPoint, self.color)
    end
    self.rotationState:increment()
end

function Tetromino:rotateCcw()
    absRotationPoint = sum(self.origin, properties.ROTATION_POINTS[self.id])
    for i, square in pairs(self.squares) do
        currentSquare = diff(Point:new(square.x, square.y), absRotationPoint)
        topLeft = sum(currentSquare, Point:new(0, 1))
        newPoint = sum(Point:new(-topLeft.y, topLeft.x), absRotationPoint)
        self.squares[i] = Square:new(newPoint, self.color)
    end
    self.rotationState:decrement()
end

function Tetromino:render(unit)
    for _, square in pairs(self.squares) do
        square:render(unit)
    end
end

return Tetromino
