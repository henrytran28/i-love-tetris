local config = require("config")

local Timer = require("timer/timer")
leftTimer = Timer:new()
rightTimer = Timer:new()
downTimer = Timer:new()
gravityTimer = Timer:new()
tetrominoExpiryTimer = Timer:new()

function love.update(dt)
    if love.keyboard.isDown("left") then
        leftTimer:add(dt)
        if leftTimer:exceeds(Timer.calculateTime(0.1, 0.3, config.delayedAutoShiftPercent)) then
            leftTimer:subtract(Timer.calculateTime(0.1, 0.01, config.leftRightSpeedPercent))
            board.movement:moveLeft()
        end
    else
        leftTimer:reset()
    end

    if love.keyboard.isDown("right") then
        rightTimer:add(dt)
        if rightTimer:exceeds(Timer.calculateTime(0.1, 0.3, config.delayedAutoShiftPercent)) then
            rightTimer:subtract(Timer.calculateTime(0.1, 0.01, config.leftRightSpeedPercent))
            board.movement:moveRight()
        end
    else
        rightTimer:reset()
    end

    if love.keyboard.isDown("down") then
        downTimer:add(dt)
        if downTimer:exceeds(Timer.calculateTime(0.1, 0.3, config.delayedAutoShiftPercent)) then
            downTimer:subtract(Timer.calculateTime(0.1, 0.01, config.leftRightSpeedPercent))
            board.movement:moveDown()
        end
    else
        downTimer:reset()
    end

    gravityTimer:add(dt)
    if gravityTimer:exceeds(Timer.calculateTime(0.1, 0.3, config.gravitySpeedPercent)) then
        board.movement:moveDown()
        gravityTimer:reset()
    end

    if board:obstacleBelow() then
        tetrominoExpiryTimer:add(dt)
        if tetrominoExpiryTimer:exceeds(1) then
            board.movement:hardDrop()
            tetrominoExpiryTimer:reset()
        end
    end
end
