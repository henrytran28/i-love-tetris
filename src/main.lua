local keyboard = require("keyboard")
local Board = require("board")

local unit = 40
local board = Board:new(10, 22, unit)

width = (board.width + 8) * unit
height = (board.height - 2) * unit
keyboard.init(board)
love.window.setMode(width, height, nil)

function love.draw()
    board:render()
end
