local Board = require("board")
local timers = require("timers")
local config = require("config")
local colors = require("colors")

unit = 40
width = 10 * unit
height = 22 * unit
love.window.setMode(width, height, nil)

function love.load()
    paused = false
    love.graphics.setFont(love.graphics.newFont(48))
    middleX = love.graphics.getWidth() / 2
    middleY = love.graphics.getHeight() / 2
end

function pauseGame()
    love.graphics.setColor(colors.WHITE)
    love.graphics.printf("PAUSED", middleX / 2, middleY, middleX, "center")
end

function love.draw()
    if paused then
        pauseGame()
    else
        Board:render()
    end
end

function love.focus(focus)
    if not focus then
        paused = true
    end
end

function love.keypressed(key, scancode, isrepeat)
    if key == "p" then
        paused = not paused
    end
    if paused then
        return
    end
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
    if key == "escape" then
        love.event.quit()
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
    if paused then
        return
    end
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
end

function calculateTime(timeAtMin, timeAtMax, speedPercent)
    return ((timeAtMax - timeAtMin) / 100) * speedPercent + timeAtMin
end
