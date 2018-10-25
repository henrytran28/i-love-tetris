local Timer = require("timer/timer")
local utils = require("utils/utils")
local settings = require("settings/settings")

local Controller = {}

function Controller:new(board)
    local controller = {
        board = board,
        timers = {
            ['moveLeft'] = Timer:new(),
            ['moveRight'] = Timer:new(),
            ['moveDown'] = Timer:new(),
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
    repeatActions = {'moveLeft', 'moveRight', 'moveDown'}
    for _, action in pairs(repeatActions) do
        for _, key in pairs(settings.keyBindings[action]) do
            if love.keyboard.isDown(key) then
                self.timers[action]:add(dt)
                if self.timers[action]:exceeds(utils.linearInterpolation(0.1, 0.3, settings.delayedAutoShiftPercent)) then
                    self.timers[action]:subtract(utils.linearInterpolation(0.1, 0.01, settings.leftRightSpeedPercent))
                    self:run(action)
                end
            else
                self.timers[action]:reset()
            end
        end
    end
end

return Controller
