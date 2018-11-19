local FrameCounter = require("frame_counter/frame_counter")
local utils = require("utils/utils")
local settings = require("settings/settings")
local Action = require("controller/action")

local Controller = {}

function Controller:new(board)
    local controller = {
        board = board,
        frameCounters = {
            moveLeft = FrameCounter:new(1/settings.leftRightSpeed),
            moveRight = FrameCounter:new(1/settings.leftRightSpeed),
            moveDown = FrameCounter:new(1/settings.softDropSpeed),
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
    self:run(utils.getKeyFromValue(settings.keyBindings, key))
end

function Controller:handleRepeatKeys(frames)
    for action, _ in pairs(self.frameCounters) do
        if love.keyboard.isDown(settings.keyBindings[action]) then
            self.frameCounters[action]:add(frames)
            if self.frameCounters[action]:exceeds(settings.autoShiftDelay) then
                self.frameCounters[action]:subtract(self.frameCounters[action].maxFrames)
                self:run(action)
            end
        else
            self.frameCounters[action]:reset()
        end
    end
end

return Controller
