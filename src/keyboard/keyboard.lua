local Board = require("board/board")
local timer = require("keyboard/timer")
local config = require("config")

local Keyboard = {}
local board = {}

function Keyboard.init(b)
    board = b
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
        timer.left = 0
    end
    if key == "right" then
        timer.right = 0
    end
    if key == "down" then
        timer.down = 0
    end
end

function love.update(dt)
    if love.keyboard.isDown("left") then
        timer.left = timer.left + dt
        if timer.left >= timer.calculateTime(0.1, 0.3, config.delayedAutoShiftPercent) then
            timer.left = timer.left - timer.calculateTime(0.1, 0.01, config.leftRightSpeedPercent)
            board.movement:moveLeft()
        end
    end

    if love.keyboard.isDown("right") then
        timer.right = timer.right + dt
        if timer.right >= timer.calculateTime(0.1, 0.3, config.delayedAutoShiftPercent) then
            timer.right = timer.right - timer.calculateTime(0.1, 0.01, config.leftRightSpeedPercent)
            board.movement:moveRight()
        end
    end
    if love.keyboard.isDown("down") then
        timer.down = timer.down + dt
        if timer.down >= timer.calculateTime(0.1, 0.3, config.delayedAutoShiftPercent) then
            timer.down = timer.down - timer.calculateTime(0.1, 0.01, config.softDropSpeedPercent)
            board.movement:moveDown()
        end
    end
end

return Keyboard
