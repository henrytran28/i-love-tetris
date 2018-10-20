local Board = require("board/board")
local Tetromino = require("tetromino/tetromino")

describe("#Board", function() -- tagged as "board"
    local function tableContains(table, value)
        for i = 1, #table do
            if table[i] == value then return true end
        end
        return false
    end

    it("Constructor", function()
        local ids = {"O", "I", "J", "L", "S", "Z", "T"}
        local board = Board:new(10, 22)
        assert.are.equal(board.width, 10)
        assert.are.equal(board.height, 22)
        assert.is.falsy(next(board.boardTetrominoSquares))
        assert.is.truthy(board.boardTetrominosMatrix)
        assert.is.truthy(board.movement)
        assert.is_true(board.holdable)
        assert.True(tableContains(ids, board.currentTetromino.id))
        assert.True(tableContains(ids, board.nextTetromino.id))
        assert.True(tableContains(ids, board.ghostTetromino.id))
    end)

    it("CycleNextTetromino", function()
        local board = Board:new(10, 22)
        for i = 0, 99, 1 do
            lastTetrominoID = board.currentTetromino.id
            board:cycleNextTetromino()
            if i + 1 % 7 ~= 0 then
                assert.are_not.equals(board.currentTetromino.id,
                    lastTetrominoID)
            end
        end
    end)
end)
