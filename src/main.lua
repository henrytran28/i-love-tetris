local keyboard = require("keyboard")
local Board = require("board")
local properties = require("properties")

local unit = 30
local board = Board:new(10, 22, unit)
local leftPadding = 8

local width = (board.width + leftPadding) * unit
local height = (board.height - 2) * unit

keyboard.init(board)
love.window.setMode(width, height, nil)

function love.draw()
    board:render()
end
