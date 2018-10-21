local settings = require("settings/settings")

local Timer = require("timer/timer")
local leftTimer = Timer:new()
local rightTimer = Timer:new()
local downTimer = Timer:new()
local gravityTimer = Timer:new()
local tetrominoExpiryTimer = Timer:new()

function love.update(dt)
    if love.keyboard.isDown("left") then
        leftTimer:add(dt)
        if leftTimer:exceeds(Timer.calculateTime(0.1, 0.3, settings.delayedAutoShiftPercent)) then
            leftTimer:subtract(Timer.calculateTime(0.1, 0.01, settings.leftRightSpeedPercent))
            board.movement:moveLeft()
        end
    else
        leftTimer:reset()
    end

    if love.keyboard.isDown("right") then
        rightTimer:add(dt)
        if rightTimer:exceeds(Timer.calculateTime(0.1, 0.3, settings.delayedAutoShiftPercent)) then
            rightTimer:subtract(Timer.calculateTime(0.1, 0.01, settings.leftRightSpeedPercent))
            board.movement:moveRight()
        end
    else
        rightTimer:reset()
    end

    if love.keyboard.isDown("down") then
        downTimer:add(dt)
        if downTimer:exceeds(Timer.calculateTime(0.1, 0.3, settings.delayedAutoShiftPercent)) then
            downTimer:subtract(Timer.calculateTime(0.1, 0.01, settings.leftRightSpeedPercent))
            board.movement:moveDown()
        end
    else
        downTimer:reset()
    end

    gravityTimer:add(dt)
    if gravityTimer:exceeds(Timer.calculateTime(0.1, 0.3, settings.gravitySpeedPercent)) then
        board.movement:moveDown()
        gravityTimer:reset()
    end

    if board:obstacleBelow() then
        tetrominoExpiryTimer:add(dt)
        if tetrominoExpiryTimer:exceeds(1.0) then
            board.movement:hardDrop()
            tetrominoExpiryTimer:reset()
        end
    end
end
