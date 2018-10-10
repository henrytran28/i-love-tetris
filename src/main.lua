local keyboard = require("keyboard")
local Board = require("board")

local board = Board:new(10, 22)
local nextPieceBoard = Board:new(5, 4)

unit = 40
width = board.width * unit
height = (board.height - 2) * unit
keyboard.init(board)
love.window.setMode(width, height, nil)


function love.draw()
    board:render()
end
