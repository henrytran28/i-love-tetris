local colors = require("colors/colors")
local Tetromino = require("tetromino/tetromino")
local properties = require("tetromino/properties")
local constants = require("constants")
local Movement = require("movement/movement")
local Randomizer = require("randomizer/randomizer")
local Matrix = require("board/matrix")
local utils = require("utils/utils")

local Board = {}

function Board:new(width, height)
    local board = {
        width = width,
        height = height,
        boardTetrominosMatrix = Matrix:new(width, height),
        boardTetrominoSquares = {},
        holdable = true,
        heldTetromino = nil
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
    self:updateMatrices()
    ghost = Tetromino:new(self.currentTetromino.id,
        self.currentTetromino.origin, colors.ASH)
    for i = 1, self.currentTetromino.rotationState.value do
        ghost:rotateCw()
    end
    for i = 0, self.height do
        ghost:offset(0, -1)
        for _, square in pairs(ghost.squares) do
            if square.y < 0 or self.boardTetrominosMatrix[square.x][square.y] == 1 then
                ghost:offset(0, 1)
                break
            end
        end
    end
    return ghost
end

function Board:cycleNextTetromino()
    self:updateMatrices()
    self.currentTetromino = self.nextTetromino
    self:checkOverlappingSpawn()
    self.ghostTetromino = self:getGhostTetromino()
    self.nextTetromino = Randomizer:next()
end

function Board:checkOverlappingSpawn()
    for _, square in pairs(self.currentTetromino.squares) do
        if self.boardTetrominosMatrix:isFilled(square.x, square.y) then
            self.currentTetromino:offset(0, 1)
            self:checkGameOver()
        end
    end
end

function Board:checkGameOver()
    for _, square in pairs(self.currentTetromino.squares) do
        if square.y >= self.height then
            return true
        end
    end
    return false
end

function Board:updateMatrices()
    self.boardTetrominosMatrix:clear()
    for _, square in pairs(self.boardTetrominoSquares) do
        self.boardTetrominosMatrix:fill(square.x, square.y)
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
    self:updateMatrices()

    -- Render the background
    self:renderBackground()

    -- Render the ghost tetromino
    self.ghostTetromino:render()

    -- Render pieces except current one
    for _, square in pairs(self.boardTetrominoSquares) do
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
    boardTetrominoSquaresCopy = utils.shallowcopy(self.boardTetrominoSquares)
    for _, index in pairs(indices) do
        for _, square in pairs(self.boardTetrominoSquares) do
            if square.y == index then
                squareToRemove = self:getTetrominoSquareIndex(boardTetrominoSquaresCopy,
                                                              square.x, square.y)
                if squareToRemove ~= nil then
                    table.remove(boardTetrominoSquaresCopy, squareToRemove)
                end
            end
        end
    end
    self.boardTetrominoSquares = utils.shallowcopy(boardTetrominoSquaresCopy)
end

function Board:dropLines(indices)
    for linesDropped, index in pairs(indices) do
        for key, square in pairs(self.boardTetrominoSquares) do
            if square.y > index - linesDropped then
                square.y = square.y - 1
            end
        end
    end
    self.ghostTetromino = self:getGhostTetromino()
end

return Board
