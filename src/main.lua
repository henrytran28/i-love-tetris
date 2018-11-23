local Board = require("board/board")
local constants = require("constants")
local Tetrion = require("tetrion/tetrion")
local Controller = require("controller/controller")
local settings = require("settings/settings")

love.window.setTitle("I Love Tetris")
love.window.setMode(constants.WINDOW_WIDTH, constants.WINDOW_HEIGHT, nil)

local board = Board:new(10, 22)
local tetrion = Tetrion:new(board)
local controller = Controller:new(board)

function love.draw()
    board:render()
    tetrion:render()
    local curTime = love.timer.getTime()
    if nextTime <= curTime then
        nextTime = curTime
        return
    end
    love.timer.sleep(nextTime - curTime)
end

function love.keypressed(key, scancode, isrepeat)
    controller:handleNonRepeatKeys(key, scancode, isrepeat)
end

function love.load()
    minDt = 1/settings.fpsCap
    nextTime = love.timer.getTime()
end

function love.update(dt)
    nextTime = nextTime + minDt

    local fps = love.timer.getFPS()
    controller:handleRepeatKeys(dt * fps)
    -- board:handleGravity(dt * fps)
end
