local Board = require("board")
local Keyboard = require("keyboard")
local Board = require("board")

unit = 40
width = Board.width * unit
height = (Board.height - 2) * unit
love.window.setMode(width, height, nil)

function love.draw()
    Board:render()
end
