local timer = require("keyboard/timer")
local config = require("config")

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