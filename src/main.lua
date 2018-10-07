local Board = require("board")
local timers = require("timers")
local config = require("config")

unit = 40
width = Board.width * unit
height = (Board.height - 2) * unit
love.window.setMode(width, height, nil)

function love.draw()
    Board:render()
end

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
            Board.movement:moveLeft()
        end
    end

    if love.keyboard.isDown("right") then
        timers.right = timers.right + dt
        if timers.right >= calculateTime(0.1, 0.3, config.delayedAutoShiftPercent) then
            timers.right = timers.right - calculateTime(0.1, 0.01, config.leftRightSpeedPercent)
            Board.movement:moveRight()
        end
    end

    if love.keyboard.isDown("down") then
        timers.down = timers.down + dt
        if timers.down >= calculateTime(0.1, 0.3, config.delayedAutoShiftPercent) then
            timers.down = timers.down - calculateTime(0.1, 0.01, config.softDropSpeedPercent)
            Board.movement:moveDown()
        end
    end

    timers.gravity = timers.gravity + dt
    if timers.gravity >= calculateTime(1, 0.1, config.gravitySpeed) then
        gravitate()
    end
end

function gravitate()
    Board.movement:moveDown() 
    timers.gravity = 0
end

function calculateTime(timeAtMin, timeAtMax, speedPercent)
    return ((timeAtMax - timeAtMin) / 100) * speedPercent + timeAtMin
end
