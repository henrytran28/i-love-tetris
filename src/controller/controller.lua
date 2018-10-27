local Timer = require("timer/timer")
local utils = require("utils/utils")
local settings = require("settings/settings")

local Controller = {}

function Controller:new(board)
    local controller = {
        board = board,
        timers = {
            moveLeft = Timer:new(0, utils.linearInterpolation(0.1, 0.01, settings.leftRightSpeedPercent)),
            moveRight = Timer:new(0, utils.linearInterpolation(0.1, 0.01, settings.leftRightSpeedPercent)),
            moveDown = Timer:new(0, utils.linearInterpolation(0.1, 0.01, settings.softDropSpeedPercent)),
        },
        funcTable = {
            moveLeft = "self.board.movement:moveLeft()",
            moveRight = "self.board.movement:moveRight()",
            moveDown = "self.board.movement:moveDown()",
            rotateCw = "self.board.movement:rotateCw()",
            rotateCcw = "self.board.movement:rotateCcw()",
            hardDrop = "self.board.movement:hardDrop()",
            hold = "self.board:holdCurrentTetromino()",
        }
    }
    self.__index = self
    setmetatable(controller, self)
    return controller
end

function Controller:run(action)
    loadstring("local self = ...; " .. self.funcTable[action])(self)
end

function Controller:handleNonRepeatKeys(key, scancode, isrepeat)
    for action, keyStrList in pairs(settings.keyBindings) do
        for _, keyStr in pairs(keyStrList) do
            if key == keyStr then
                self:run(action)
            end
        end
    end
end

function Controller:handleRepeatKeys(dt)
    autoShiftDelay = utils.linearInterpolation(0.1, 0.3, settings.delayedAutoShiftPercent)

    for action, _ in pairs(self.timers) do
        if love.keyboard.isDown(settings.keyBindings[action]) then
            self.timers[action]:add(dt)
            if self.timers[action]:exceeds(autoShiftDelay) then
                self.timers[action]:subtract(self.timers[action].max)
                self:run(action)
            end
        else
            self.timers[action]:reset()
        end
    end
end

return Controller
