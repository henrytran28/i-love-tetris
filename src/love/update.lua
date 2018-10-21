local config = require("config")

local Timer = require("keyboard/timer")
leftTimer = Timer:new()
rightTimer = Timer:new()
downTimer = Timer:new()
gravityTimer = Timer:new()

function love.update(dt)
    if love.keyboard.isDown("left") then
        leftTimer:add(dt)
        if leftTimer.value >= Timer.calculateTime(0.1, 0.3, config.delayedAutoShiftPercent) then
            leftTimer:subtract(Timer.calculateTime(0.1, 0.01, config.leftRightSpeedPercent))
            board.movement:moveLeft()
        end
    else
        leftTimer:reset()
    end

    if love.keyboard.isDown("right") then
        rightTimer:add(dt)
        if rightTimer.value >= Timer.calculateTime(0.1, 0.3, config.delayedAutoShiftPercent) then
            rightTimer:subtract(Timer.calculateTime(0.1, 0.01, config.leftRightSpeedPercent))
            board.movement:moveRight()
        end
    else
        rightTimer:reset()
    end

    if love.keyboard.isDown("down") then
        downTimer:add(dt)
        if downTimer.value >= Timer.calculateTime(0.1, 0.3, config.delayedAutoShiftPercent) then
            downTimer:subtract(Timer.calculateTime(0.1, 0.01, config.leftRightSpeedPercent))
            board.movement:moveDown()
        end
    else
        downTimer:reset()
    end

    gravityTimer:add(dt)
    if gravityTimer.value <= 0 then
        board.movement:gravitate()
    end
end
