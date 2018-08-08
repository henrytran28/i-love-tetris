local colors = require("colors")
local Tetromino = require("tetromino")
local properties = require("properties")
local Movement = require("movement")
local Randomizer = require("randomizer")
local Matrix = require("matrix")

local Board = {
    width = 10, 
    height = 22
}

function Board:getGhostTetromino()
    self:updateMatrices()
    ghost = Tetromino:new(self.currentTetromino.id, self.currentTetromino.origin, colors.ASH)
    for i = 0, self.currentTetromino.state - 1 do
        ghost:rotateCw()
    end
    for i = 0, self.height do
        ghost:offset(0, -1)
        for _, square in pairs(ghost.squares) do
            if square.y < 0 or self.boardTetrominosMatrix[square.x][square.y] == 1 then
                ghost:offset(0, 1)
                break
            end
        end
    end
    return ghost
end

function Board:switchCurrentTetromino()
    self.currentTetromino = self.nextTetromino
    self.ghostTetromino = self:getGhostTetromino()
    self.nextTetromino = Randomizer:next()
end

function Board:updateMatrices()
    self.boardTetrominosMatrix:clear()
    for _, square in pairs(self.boardTetrominoSquares) do
        self.boardTetrominosMatrix:fill(square.x, square.y)
    end
end

function Board:renderBackground()
    for i = 0, self.width, 1 do
        for j = 0, self.height, 1 do
            if (i % 2 == 0 and j % 2 == 0) or
               ((i + 1) % 2 == 0 and (j + 1) % 2 == 0) then
                love.graphics.setColor(colors.CHARCOAL)
            else
                love.graphics.setColor(colors.JET)
            end
            love.graphics.rectangle("fill", i * unit, j * unit, unit, unit)
        end
    end
end

function Board:render()
    self:updateMatrices()

    -- Render the background
    self:renderBackground()

    -- Render the ghost tetromino
    self.ghostTetromino:render()

    -- Render pieces except current one
    for _, square in pairs(self.boardTetrominoSquares) do
        square:render()
    end

    -- Render current playable tetromino
    self.currentTetromino:render()
end

Randomizer:newList()
Board.currentTetromino = Randomizer:next()
Board.nextTetromino = Randomizer:next()
Board.movement = Movement:init(Board)
Board.boardTetrominoSquares = {}
Board.boardTetrominosMatrix = Matrix:new(Board.width, Board.height)
Board.ghostTetromino = Board:getGhostTetromino()

return Board