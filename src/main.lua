local keyboard = require("keyboard/keyboard")
local Board = require("board/board")
local constants = require("constants")
local Tetrion = require("tetrion/tetrion")

local board = Board:new(10, 22)
tetrion = Tetrion:new(board)

keyboard.init(board)
love.window.setMode(constants.WINDOW_WIDTH, constants.WINDOW_HEIGHT, nil)

function love.draw()
    board:render()
    tetrion:render()
end
