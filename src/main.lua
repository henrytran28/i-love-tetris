local Board = require("board")
local timers = require("timers")
local config = require("config")

unit = 40
width = 10 * unit
height = 22 * unit
love.window.setMode(width, height, nil)

board = Board:new(10, 22)

function love.draw()
    board:render()
end

function love.keypressed(key, scancode, isrepeat)
    if key == "left" then
        board.movement:moveLeft()
    end
    if key == "right" then
        board.movement:moveRight()
    end
    if key == "down" then
        board.movement:moveDown()
    end
    if key == "up" then
        board.movement:rotateCw()
    end
    if key == "z" then
        board.movement:rotateCcw()
    end
    if key == "space" then
        board.movement:hardDrop()
    end
    if key == "lshift" or key == "rshift" or key == "c" then
        board:holdCurrentTetromino()
    end
end

function love.keyreleased(key, scancode, isrepeat)
    if key == "left" then
        timers.left = 0
    end
    if key == "right" then
        timers.right = 0
    end
    if key == "down" then
        timers.down = 0
    end
end

function love.update(dt)
    if love.keyboard.isDown("left") then
        timers.left = timers.left + dt
        if timers.left >= calculateTime(0.1, 0.3, config.delayedAutoShiftPercent) then
            timers.left = timers.left - calculateTime(0.1, 0.01, config.leftRightSpeedPercent)
            board.movement:moveLeft()
        end
    end

    if love.keyboard.isDown("right") then
        timers.right = timers.right + dt
        if timers.right >= calculateTime(0.1, 0.3, config.delayedAutoShiftPercent) then
            timers.right = timers.right - calculateTime(0.1, 0.01, config.leftRightSpeedPercent)
            board.movement:moveRight()
        end
    end
    if love.keyboard.isDown("down") then
        timers.down = timers.down + dt
        if timers.down >= calculateTime(0.1, 0.3, config.delayedAutoShiftPercent) then
            timers.down = timers.down - calculateTime(0.1, 0.01, config.softDropSpeedPercent)
            board.movement:moveDown()
        end
    end
end

function calculateTime(timeAtMin, timeAtMax, speedPercent)
    return ((timeAtMax - timeAtMin) / 100) * speedPercent + timeAtMin
end
