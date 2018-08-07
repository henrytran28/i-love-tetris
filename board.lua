local colors = require("colors")
local Tetromino = require("tetromino")
local properties = require("properties")
local Movement = require("movement")

local Board = {width = 10, height = 22}

local id = "I"
Board.currentTetromino = Tetromino:new(id, properties.SPAWN[id], properties.COLORS[id])
Board.movement = Movement:init(Board)

function Board:render()
    self:renderBackground()
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