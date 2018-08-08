local colors = require("colors")
local Tetromino = require("tetromino")
local properties = require("properties")
local Movement = require("movement")
local Randomizer = require("randomizer")

local Board = {width = 10, height = 22}

Randomizer:newList()
Board.currentTetromino = Randomizer:next()
Board.nextTetromino = Randomizer:next()
Board.movement = Movement:init(Board)
Board.boardTetrominoSquares = {}

function Board:switchCurrentTetromino()
    self.currentTetromino = self.nextTetromino
    -- self.ghostTetromino = self.getGhostTetromino()
    self.nextTetromino = Randomizer:next()
end

function Board:render()
    -- Render the background
    self:renderBackground()

    -- Render pieces except current one
    for _, square in pairs(self.boardTetrominoSquares) do
        square:render()
    end

    -- Render current playable tetromino
    self.currentTetromino:render()
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

return Board