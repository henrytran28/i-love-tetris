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
    }
    self.__index = self
    setmetatable(controller, self)
    return controller
end

function Controller:run(action)
    if action == 'moveLeft' then self.board.movement:moveLeft() end
    if action == 'moveRight' then self.board.movement:moveRight() end
    if action == 'moveDown' then self.board.movement:moveDown() end
    if action == 'rotateCw' then self.board.movement:rotateCw() end
    if action == 'rotateCcw' then self.board.movement:rotateCcw() end
    if action == 'hardDrop' then self.board.movement:hardDrop() end
    if action == 'hold' then self.board:holdCurrentTetromino() end
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
