local Board = require("board/board")
local properties = require("tetromino/properties")
local Tetromino = require("tetromino/tetromino")
local inspect = require("inspect")

describe("#Board", function() -- tagged as "board"
    local board

    local function tableContains(table, value)
        for i = 1, #table do
            if table[i] == value then return true end
        end
        return false
    end

    before_each(function()
        board = Board:new(10, 22)
    end)

    it("Constructor", function()
        local ids = {"O", "I", "J", "L", "S", "Z", "T"}
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

    it("GetGhostTetromino", function()
        board.currentTetromino = Tetromino:new("O", properties.SPAWN["O"],
            properties.COLORS["O"])
        board.ghostTetromino = board:getGhostTetromino()
        ghostSquares = board.ghostTetromino.squares

        assert(ghostSquares[1].x, 4)
        assert(ghostSquares[1].y, 0)
        assert(ghostSquares[2].x, 5)
        assert(ghostSquares[2].y, 0)
        assert(ghostSquares[3].x, 5)
        assert(ghostSquares[3].y, 1)
        assert(ghostSquares[4].x, 4)
        assert(ghostSquares[4].y, 1)
    end)

    it("CycleNextTetromino", function()
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
