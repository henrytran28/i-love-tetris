local keyboard = require("keyboard")
local Board = require("board")
local properties = require("properties")

local board = Board:new(properties.WIDTH, properties.HEIGHT)

windowWidth = (board.width + properties.XOFFSET) * properties.UNIT
windowHeight = (board.height - 2) * properties.UNIT

keyboard.init(board)
love.window.setMode(windowWidth, windowHeight, nil)

function love.draw()
    board:render()
end
