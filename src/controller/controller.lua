local Timer = require("timer/timer")
local utils = require("utils/utils")
local settings = require("settings/settings")
local movement = require("movement/movement")

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
    if key == "left" then
        self.board.movement:moveLeft()
    end
    if key == "right" then
        self.board.movement:moveRight()
    end
    if key == "down" then
        self.board.movement:moveDown()
    end
    if key == "up" then
        self.board.movement:rotateCw()
    end
    if key == "z" then
        self.board.movement:rotateCcw()
    end
    if key == "space" then
        self.board.movement:hardDrop()
    end
    if key == "lshift" or key == "rshift" or key == "c" then
        self.board:holdCurrentTetromino()
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
