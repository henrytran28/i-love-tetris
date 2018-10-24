local Timer = require("timer/timer")
local utils = require("utils/utils")
local settings = require("settings/settings")

local Controller = {}

function Controller:new(board)
    local controller = {
        board = board,
        leftTimer = Timer:new(),
        rightTimer = Timer:new(),
        downTimer = Timer:new(),
    }
    self.__index = self
    setmetatable(controller, self)
    return controller
end

function Controller:handleNonRepeatKeys(key, scancode, isrepeat)
    for action, keyStrList in pairs(settings.keyBindings) do
        for _, keyStr in pairs(keyStrList) do
            if key == keyStr then
                -- https://stackoverflow.com/questions/45016391
                loadstring("local self = ...; "..action.."()")(self)
            end
        end
    end
end

function Controller:handleRepeatKeys(dt)
    if love.keyboard.isDown("left") then
        self.leftTimer:add(dt)
        if self.leftTimer:exceeds(utils.linearInterpolation(0.1, 0.3, settings.delayedAutoShiftPercent)) then
            self.leftTimer:subtract(utils.linearInterpolation(0.1, 0.01, settings.leftRightSpeedPercent))
            self.board.movement:moveLeft()
        end
    else
        self.leftTimer:reset()
    end

    if love.keyboard.isDown("right") then
        self.rightTimer:add(dt)
        if self.rightTimer:exceeds(utils.linearInterpolation(0.1, 0.3, settings.delayedAutoShiftPercent)) then
            self.rightTimer:subtract(utils.linearInterpolation(0.1, 0.01, settings.leftRightSpeedPercent))
            self.board.movement:moveRight()
        end
    else
        self.rightTimer:reset()
    end

    if love.keyboard.isDown("down") then
        self.downTimer:add(dt)
        if self.downTimer:exceeds(utils.linearInterpolation(0.1, 0.3, settings.delayedAutoShiftPercent)) then
            self.downTimer:subtract(utils.linearInterpolation(0.1, 0.01, settings.leftRightSpeedPercent))
            self.board.movement:moveDown()
        end
    else
        self.downTimer:reset()
    end
end

return Controller