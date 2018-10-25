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

Controller.funcMap = {
    ['moveLeft'] = 'self.board.movement:moveLeft()',
    ['moveRight'] = 'self.board.movement:moveRight()',
    ['moveDown'] = 'self.board.movement:moveDown()',
    ['rotateCw'] = 'self.board.movement:rotateCw()',
    ['rotateCcw'] = 'self.board.movement:rotateCcw()',
    ['hardDrop'] = 'self.board.movement:hardDrop()',
    ['hold'] = 'self.board:holdCurrentTetromino()',
}

function Controller:run(action)
    loadstring("local self = ...; "..self.funcMap[action])(self)
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
