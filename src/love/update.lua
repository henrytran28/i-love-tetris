local settings = require("settings/settings")
local utils = require("utils/utils")

local Timer = require("timer/timer")
local leftTimer = Timer:new()
local rightTimer = Timer:new()
local downTimer = Timer:new()
local gravityTimer = Timer:new()
local tetrominoExpiryTimer = Timer:new()

function love.update(dt)
    if love.keyboard.isDown("left") then
        leftTimer:add(dt)
        if leftTimer:exceeds(utils.linearInterpolation(0.1, 0.3, settings.delayedAutoShiftPercent)) then
            leftTimer:subtract(utils.linearInterpolation(0.1, 0.01, settings.leftRightSpeedPercent))
            board.movement:moveLeft()
        end
    else
        leftTimer:reset()
    end

    if love.keyboard.isDown("right") then
        rightTimer:add(dt)
        if rightTimer:exceeds(utils.linearInterpolation(0.1, 0.3, settings.delayedAutoShiftPercent)) then
            rightTimer:subtract(utils.linearInterpolation(0.1, 0.01, settings.leftRightSpeedPercent))
            board.movement:moveRight()
        end
    else
        rightTimer:reset()
    end

    if love.keyboard.isDown("down") then
        downTimer:add(dt)
        if downTimer:exceeds(utils.linearInterpolation(0.1, 0.3, settings.delayedAutoShiftPercent)) then
            downTimer:subtract(utils.linearInterpolation(0.1, 0.01, settings.leftRightSpeedPercent))
            board.movement:moveDown()
        end
    else
        downTimer:reset()
    end

    gravityTimer:add(dt)
    if gravityTimer:exceeds(utils.linearInterpolation(1.0, 0.5, settings.gravitySpeedPercent)) then
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
