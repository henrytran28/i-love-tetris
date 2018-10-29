local Timer = require("timer/timer")
local utils = require("utils/utils")
local settings = require("settings/settings")
local Action = require("controller/action")

local Controller = {}

function Controller:new(board)
    local controller = {
        board = board,
        timers = {
            moveLeft = Timer:new(0, utils.linearInterpolation(0.1, 0.01, settings.leftRightSpeedPercent)),
            moveRight = Timer:new(0, utils.linearInterpolation(0.1, 0.01, settings.leftRightSpeedPercent)),
            moveDown = Timer:new(0, utils.linearInterpolation(0.1, 0.01, settings.softDropSpeedPercent)),
        },
        actions = {
            moveLeft = Action:new(settings.keyBindings.moveLeft, "self.board.movement:moveLeft()"),
            moveRight = Action:new(settings.keyBindings.moveRight, "self.board.movement:moveRight()"),
            moveDown = Action:new(settings.keyBindings.moveDown, "self.board.movement:moveDown()"),
            rotateCw = Action:new(settings.keyBindings.rotateCw, "self.board.movement:rotateCw()"),
            rotateCcw = Action:new(settings.keyBindings.rotateCcw, "self.board.movement:rotateCcw()"),
            hardDrop = Action:new(settings.keyBindings.hardDrop, "self.board.movement:hardDrop()"),
            hold = Action:new(settings.keyBindings.hold, "self.board:holdCurrentTetromino()"),
        }
    }
    self.__index = self
    setmetatable(controller, self)
    return controller
end

function Controller:run(action)
    if action ~= nil then
        loadstring("local self = ...; " .. self.actions[action].funcStr)(self)
    end
end

function Controller:handleNonRepeatKeys(key, scancode, isrepeat)
    self:run(utils.invertTable(settings.keyBindings)[key])
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
