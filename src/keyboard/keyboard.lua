local Board = require("src/board/board")
local timer = require("src/keyboard/timer")
local config = require("config")

function love.keypressed(key, scancode, isrepeat)
    if key == "left" then
        Board.movement:moveLeft()
    end
    if key == "right" then
        Board.movement:moveRight()
    end
    if key == "down" then
        Board.movement:moveDown()
    end
    if key == "up" then
        Board.movement:rotateCw()
    end
    if key == "z" then
        Board.movement:rotateCcw()
    end
    if key == "space" then
        Board.movement:hardDrop()
    end
    if key == "lshift" or key == "rshift" or key == "c" then
        Board:holdCurrentTetromino()
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
            Board.movement:moveLeft()
        end
    end

    if love.keyboard.isDown("right") then
        timer.right = timer.right + dt
        if timer.right >= timer.calculateTime(0.1, 0.3, config.delayedAutoShiftPercent) then
            timer.right = timer.right - timer.calculateTime(0.1, 0.01, config.leftRightSpeedPercent)
            Board.movement:moveRight()
        end
    end
    if love.keyboard.isDown("down") then
        timer.down = timer.down + dt
        if timer.down >= timer.calculateTime(0.1, 0.3, config.delayedAutoShiftPercent) then
            timer.down = timer.down - timer.calculateTime(0.1, 0.01, config.softDropSpeedPercent)
            Board.movement:moveDown()
        end
    end
end
