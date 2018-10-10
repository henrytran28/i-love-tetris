require("keyboard")

local Board = require("board")

board = Board:new(10, 22)

unit = 40
width = board.width * unit
height = (board.height - 2) * unit
love.window.setMode(width, height, nil)

function love.draw()
    board:render()
end
