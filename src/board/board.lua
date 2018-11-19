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
        matrix = Matrix:new(width, height),
        squares = {},
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
    self:updateMatrix()
    ghost = Tetromino:new(self.currentTetromino.id,
        self.currentTetromino.origin, colors.ASH)
    for i = 1, self.currentTetromino.rotationState.value do
        ghost:rotateCw()
    end
    for i = 0, self.height do
        ghost:offset(0, -1)
        for _, square in pairs(ghost.squares) do
            if square.y < 0 or self.matrix[square.x][square.y] == 1 then
                ghost:offset(0, 1)
                break
            end
        end
    end
    return ghost
end

function Board:cycleNextTetromino()
    self:updateMatrix()
    self.currentTetromino = self.nextTetromino
    self:checkOverlappingSpawn()
    self.ghostTetromino = self:getGhostTetromino()
    self.nextTetromino = Randomizer:next()
end

function Board:checkOverlappingSpawn()
    for _, square in pairs(self.currentTetromino.squares) do
        if self.matrix:isFilled(square.x, square.y) then
            self.currentTetromino:offset(0, 1)
            self:checkGameOver()
        end
    end
end

function Board:checkGameOver()
    for _, square in pairs(self.currentTetromino.squares) do
        if square.y >= self.height then
            print("END GAME")
            return
        end
    end
end

function Board:updateMatrix()
    self.matrix:clear()
    for _, square in pairs(self.squares) do
        self.matrix:fill(square.x, square.y)
    end
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
    self:updateMatrix()

    -- Render the background
    self:renderBackground()

    -- Render the ghost tetromino
    self.ghostTetromino:render()

    -- Render pieces except current one
    for _, square in pairs(self.squares) do
        square:render()
    end

    -- Render current playable tetromino
    self.currentTetromino:render()
end

function Board:getTetrominoSquareIndex(squares, x, y)
    for i, square in pairs(squares) do
        if square.x == x and square.y == y then
            return i
        end
    end
    return nil
end

function Board:clearLines(indices)
    squaresCopy = utils.shallowcopy(self.squares)
    for _, index in pairs(indices) do
        for _, square in pairs(self.squares) do
            if square.y == index then
                squareToRemove = self:getTetrominoSquareIndex(squaresCopy,
                                                              square.x, square.y)
                if squareToRemove ~= nil then
                    table.remove(squaresCopy, squareToRemove)
                end
            end
        end
    end
    self.squares = utils.shallowcopy(squaresCopy)
end

function Board:dropLines(indices)
    for linesDropped, index in pairs(indices) do
        for key, square in pairs(self.squares) do
            if square.y > index - linesDropped then
                square.y = square.y - 1
            end
        end
    end
    self.ghostTetromino = self:getGhostTetromino()
end

function Board:obstacleBelow()
    for _, square in pairs(self.currentTetromino.squares) do
        if square.y <= 0 or self.matrix:isFilled(square.x, square.y - 1) then
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

    if self:obstacleBelow() then
        self.expirationFrameCounter:add(frames)
        if self.expirationFrameCounter:exceeds(self.expirationFrameCounter.maxFrames) then
            self.movement:hardDrop()
            self.expirationFrameCounter:reset()
        end
    end
end

return Board
