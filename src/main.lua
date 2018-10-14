local keyboard = require("keyboard/keyboard")
local Board = require("board/board")
local constants = require("constants")

local board = Board:new(constants.WIDTH, constants.HEIGHT)

windowWidth = constants.WIDTH * constants.UNIT
windowHeight = (constants.HEIGHT - 2)* constants.UNIT

keyboard.init(board)
love.window.setMode(windowWidth, windowHeight, nil)

function love.draw()
    board:render()
end
