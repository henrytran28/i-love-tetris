local colors = require("colors/colors")
local Tetromino = require("tetromino/tetromino")
local properties = require("tetromino/properties")
local constants = require("constants")
local Movement = require("movement/movement")
local Randomizer = require("randomizer/randomizer")
local Matrix = require("board/matrix")
local utils = require("utils/utils")
local FrameCounter = require("frame_counter/frame_counter")
local settings = require("settings/settings")

local Board = {}

function Board:new(width, height)
    local board = {
        width = width,
        height = height,
        boardTetrominosMatrix = Matrix:new(width, height),
        holdable = true,
        heldTetromino = nil,
        gravityFrameCounter = FrameCounter:new(1/settings.gravitySpeed),
        expirationFrameCounter = FrameCounter:new(settings.expiryDelay)
    }
    self.__index = self
    setmetatable(board, self)
    Randomizer:newList()
    board.currentTetromino = Randomizer:next()
    board.nextTetromino = Randomizer:next()
    board.ghostTetromino = board:getGhostTetromino()
    board.movement = Movement:init(board)
    return board
end

function Board:getGhostTetromino()
    ghost = Tetromino:new(self.currentTetromino.id,
        self.currentTetromino.origin, colors.ASH)
    for i = 1, self.currentTetromino.rotationState.value do
        ghost:rotateCw()
    end
    for i = 0, self.height do
        ghost:offset(0, -1)
        if self:obstacleBelow(ghost.squares) then
            return ghost
        end
    end
    return ghost
end

function Board:cycleNextTetromino()
    self.currentTetromino = self.nextTetromino
    self:offsetOverlappingTetromino(self.currentTetromino)
    self.ghostTetromino = self:getGhostTetromino()
    self.nextTetromino = Randomizer:next()
end

function Board:offsetOverlappingTetromino(tetromino)
    while self:isOverlapping(tetromino) and tetromino.origin.y < self.height do
        tetromino:offset(0, 1)
    end
end

function Board:isOverlapping(tetromino)
    for _, square in pairs(tetromino.squares) do
        if self.boardTetrominosMatrix:isFilled(square.x, square.y) then
            return true
        end
    end
    return false
end

function Board:isGameOver()
    for _, square in pairs(self.currentTetromino.squares) do
        if square.y >= self.height then
            return true
        end
    end
    return false
end

function Board:holdCurrentTetromino()
    if not self.holdable then
        return
    end

    self.holdable = false
    if self.heldTetromino == nil then
        self.heldTetromino = Tetromino:new(self.currentTetromino.id,
             properties.SPAWN[self.currentTetromino.id],
             properties.COLORS[self.currentTetromino.id])
        self:cycleNextTetromino()
    else
        tmp = self.currentTetromino
        self.currentTetromino = self.heldTetromino
        self.heldTetromino = Tetromino:new(tmp.id, properties.SPAWN[tmp.id],
            properties.COLORS[tmp.id])
    end

    self.ghostTetromino = self:getGhostTetromino()
end

function Board:renderBackground()
    local unit = constants.UNIT
    for i = 7, self.width + 6, 1 do
        for j = 0, self.height - 3, 1 do
            if (i % 2 == 0 and j % 2 == 0) or
                ((i + 1) % 2 == 0 and (j + 1) % 2 == 0) then
                love.graphics.setColor(colors.CHARCOAL)
            else
                love.graphics.setColor(colors.JET)
            end
            love.graphics.rectangle("fill", i * unit, j * unit, unit, unit)
        end
    end
end

function Board:render()
    -- Render the background
    self:renderBackground()

    -- Render the ghost tetromino
    self.ghostTetromino:render()

    -- Render pieces except current one
    self.boardTetrominosMatrix:render()

    -- Render current playable tetromino
    self.currentTetromino:render()
end

function Board:clearLines(lines)
    for _, line in pairs(lines) do
        for x = 0, self.width - 1 do
            self.boardTetrominosMatrix:unfill(x, line)
        end
    end
end

function Board:dropLines(indices)
    for linesToDrop, line in pairs(indices) do
        for y = line - linesToDrop + 1, self.height-1 do
            for x = 0, self.width - 1 do
                if self.boardTetrominosMatrix:isFilled(x, y) then
                    self.boardTetrominosMatrix:fill(x, y - 1, self.boardTetrominosMatrix[x][y])
                    self.boardTetrominosMatrix:unfill(x, y)
                end
            end
        end
    end
    self.ghostTetromino = self:getGhostTetromino()
end

function Board:obstacleBelow(squares)
    for _, square in pairs(squares) do
        if square.y <= 0 or self.boardTetrominosMatrix:isFilled(square.x, square.y - 1) then
            return true
        end
    end
    return false
end

function Board:handleGravity(frames)
    self.gravityFrameCounter:add(frames)
    if self.gravityFrameCounter:exceeds(self.gravityFrameCounter.maxFrames) then
        self.movement:moveDown()
        self.gravityFrameCounter:reset()
    end

    if self:obstacleBelow(self.currentTetromino.squares) then
        self.expirationFrameCounter:add(frames)
        if self.expirationFrameCounter:exceeds(self.expirationFrameCounter.maxFrames) then
            self.movement:hardDrop()
            self.expirationFrameCounter:reset()
        end
    end
end

return Board
