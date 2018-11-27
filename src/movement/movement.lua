local properties = require("tetromino/properties")

local Movement = {}

function Movement:init(board)
    local movement = { board = board }
    self.__index = self
    setmetatable(movement, self)
    return movement
end

function Movement:moveLeft()
    moveable = true
    for _, square in pairs(self.board.currentTetromino.squares) do
        if square.x <= 0 or self.board.boardTetrominosMatrix:isFilled(square.x - 1, square.y) then
            moveable = false
            break
        end
    end
    if moveable then
        self.board.currentTetromino:offset(-1, 0)
        self.board.ghostTetromino = self.board:getGhostTetromino()
    end
end

function Movement:moveRight()
    moveable = true
    for _, square in pairs(self.board.currentTetromino.squares) do
        if square.x + 1 >= self.board.width or self.board.boardTetrominosMatrix:isFilled(square.x + 1, square.y) then
            moveable = false
            break
        end
    end
    if moveable then
        self.board.currentTetromino:offset(1, 0)
        self.board.ghostTetromino = self.board:getGhostTetromino()
    end
end

function Movement:moveDown()
    moveable = true
    for _, square in pairs(self.board.currentTetromino.squares) do
        if square.y <= 0 or self.board.boardTetrominosMatrix:isFilled(square.x, square.y - 1) then
            moveable = false
            break
        end
    end
    if moveable then
        self.board.currentTetromino:offset(0, -1)
        self.board.ghostTetromino = self.board:getGhostTetromino()
    end
end

function Movement:moveUp()
    moveable = true
    for _, square in pairs(self.board.currentTetromino.squares) do
        if square.y < self.board.height or self.board.boardTetrominosMatrix:isFilled(square.x, square.y + 1) then
            moveable = false
            break
        end
    end
    if moveable then
        self.board.currentTetromino:offset(0, 1)
        self.board.ghostTetromino = self.board:getGhostTetromino()
    end
end

function Movement:hardDrop()
    for i = 0, self.board.height, 1 do
        self.board.currentTetromino:offset(0, -1)
        for _, square in pairs(self.board.currentTetromino.squares) do
            if square.y < 0 or self.board.boardTetrominosMatrix:isFilled(square.x, square.y) then
                self.board.currentTetromino:offset(0, 1)
                break
            end
        end
    end

    for _, square in pairs(self.board.currentTetromino.squares) do
        self.board.boardTetrominosMatrix:fill(square.x, square.y, square.color)
    end

    self.board:cycleNextTetromino()
    self.board.holdable = true

    local filledIndices = self.board.boardTetrominosMatrix:getFilledIndices()
    self.board:clearLines(filledIndices)
    self.board:dropLines(filledIndices)

    self.board.gravityFrameCounter:reset()
    self.board.expirationFrameCounter:reset()
end

function Movement:rotateCw()
    if self.board.currentTetromino.id == "O" then return end
    self.board.currentTetromino:rotateCw()
    for _, coordinates in pairs(properties.WALL_KICKS_CW[self.board.currentTetromino.id][self.board.currentTetromino.rotationState:prev() + 1]) do
        if self:wallKickTestPass(coordinates[1], coordinates[2]) then
            self.board.ghostTetromino = self.board:getGhostTetromino()
            return
        end
    end
    self.board.currentTetromino:rotateCcw()
end

function Movement:rotateCcw()
    if self.board.currentTetromino.id == "O" then return end
    prevState = self.board.currentTetromino.state
    self.board.currentTetromino:rotateCcw()
    for _, coordinates in pairs(properties.WALL_KICKS_CCW[self.board.currentTetromino.id]
        [self.board.currentTetromino.rotationState:next() + 1]) do
        if self:wallKickTestPass(coordinates[1], coordinates[2]) then
            self.board.ghostTetromino = self.board:getGhostTetromino()
            return
        end
    end
    self.board.currentTetromino:rotateCw()
end

function Movement:wallKickTestPass(xOffset, yOffset)
    self.board.currentTetromino:offset(xOffset, yOffset)
    for _, square in pairs(self.board.currentTetromino.squares) do
        if square.x < 0 or square.x >= self.board.width or
           square.y < 0 or square.y >= self.board.height or
           self.board.boardTetrominosMatrix:isFilled(square.x, square.y) then
            self.board.currentTetromino:offset(-xOffset, -yOffset)
            return false
        end
    end
    return true
end

return Movement
