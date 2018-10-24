local Board = require("board/board")
local constants = require("constants")
local Tetrion = require("tetrion/tetrion")
local Controller = require("controller/controller")

love.window.setTitle("I Love Tetris")
love.window.setMode(constants.WINDOW_WIDTH, constants.WINDOW_HEIGHT, nil)

local board = Board:new(10, 22)
local tetrion = Tetrion:new(board)

local controller = Controller:new(board)

function love.draw()
    board:render()
    tetrion:render()
end

function love.keypressed(key, scancode, isrepeat)
    controller:handleNonRepeatKeys(key, scancode, isrepeat)
end

function love.update(dt)
    controller:handleRepeatKeys(dt)
    board:handleGravity(dt)
end
