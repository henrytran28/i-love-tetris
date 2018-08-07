local Movement = {}

function Movement:init(board)
    local movement = {}
    self.__index = Movement
    setmetatable(movement, Movement)
    self.board = board
    return movement
end

function Movement:moveLeft()
    moveable = true
    for _, square in pairs(self.board.currentTetromino.squares) do
        if square.x <= 0 then -- or self.board.boardTetrominosMatrix[square.x - 1][square.y] != 0 do
            moveable = false
            break
        end
    end
    if moveable then
        self.board.currentTetromino:offset(-1, 0)
    end
end

function Movement:moveRight()
    moveable = true
    for _, square in pairs(self.board.currentTetromino.squares) do
        if square.x + 1 >= self.board.width then -- or self.board.boardTetrominosMatrix[square.x - 1][square.y] != 0 do
            moveable = false
            break
        end
    end
    if moveable then
        self.board.currentTetromino:offset(1, 0)
    end
end

function Movement:moveDown()
    moveable = true
    for _, square in pairs(self.board.currentTetromino.squares) do
        if square.y <= 0 then -- or self.board.boardTetrominosMatrix[square.x - 1][square.y] != 0 do
            moveable = false
            break
        end
    end
    if moveable then
        self.board.currentTetromino:offset(0, -1)
    end
end

function Movement:moveUp()
    moveable = true
    for _, square in pairs(self.board.currentTetromino.squares) do
        if square.y < self.board.height then -- or self.board.boardTetrominosMatrix[square.x - 1][square.y] != 0 do
            moveable = false
            break
        end
    end
    if moveable then
        self.board.currentTetromino:offset(0, 1)
    end
end

-- def rotate_cw(self):
-- """Rotate a tetromino clockwise, corrected to boundaries and other tetrominos."""
-- if self.board.current_tetromino.id == "O":
--     log.debug("Tetromino \"O\" detected, skipping")
--     return

-- self.board.current_tetromino.rotate_cw()
-- # https://stackoverflow.com/questions/2974022
-- for i, p in enumerate(next(v for k, v in WALL_KICKS_CW.items() if self.board.current_tetromino.id in k)
--                       [self.board.current_tetromino.state.value]):
--     if self.wall_kick_test_pass(p[0], p[1]):
--         log.debug("Clockwise rotation wall kick passed Test #{} "
--                   "with offset ({}, {})".format(i + 1, p[0], p[1]))
--         self.board.ghost_tetromino = self.board.get_ghost_tetromino()
--         return

-- # if it reaches here that means all tests have failed, so rotate back
-- self.board.current_tetromino.rotate_ccw()
-- log.debug("All clockwise rotation wall kicks failed, not rotating")

function Movement:rotateCw()
    self.board.currentTetromino.rotateCw()
end

return Movement