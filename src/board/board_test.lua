local Board = require("board/board")
local properties = require("tetromino/properties")
local Tetromino = require("tetromino/tetromino")
local Square = require("square/square")
local Point = require("point/point")
local colors = require("colors/colors")

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
        assert.is_true(tableContains(ids, board.currentTetromino.id))
        assert.is_true(tableContains(ids, board.nextTetromino.id))
        assert.is_true(tableContains(ids, board.ghostTetromino.id))
    end)

    it("GetGhostTetromino", function()
        board.currentTetromino = Tetromino:new("O", properties.SPAWN["O"],
            properties.COLORS["O"])
        board.ghostTetromino = board:getGhostTetromino()
        ghostSquares = board.ghostTetromino.squares

        assert.are_equal(ghostSquares[1].x, 4)
        assert.are_equal(ghostSquares[1].y, 0)
        assert.are_equal(ghostSquares[2].x, 5)
        assert.are_equal(ghostSquares[2].y, 0)
        assert.are_equal(ghostSquares[3].x, 5)
        assert.are_equal(ghostSquares[3].y, 1)
        assert.are_equal(ghostSquares[4].x, 4)
        assert.are_equal(ghostSquares[4].y, 1)
    end)

    it("CycleNextTetromino", function()
        for i = 0, 99, 1 do
            lastTetrominoID = board.currentTetromino.id
            board:cycleNextTetromino()
            if i + 1 % 7 ~= 0 then
                assert.are_not.equal(board.currentTetromino.id,
                    lastTetrominoID)
            end
        end
    end)

    it("CheckOverlappingSpawn", function()
        board.boardTetrominosMatrix:fill(5, 19)
        board.boardTetrominosMatrix:fill(6, 19)
        board.boardTetrominosMatrix:fill(6, 20)
        board.currentTetromino = Tetromino:new("L", properties.SPAWN["L"], colors.ASH)
        board:checkOverlappingSpawn()
        assert.are_equal(board.currentTetromino.origin.x, properties.SPAWN["L"].x)
        assert.are_equal(board.currentTetromino.origin.y, properties.SPAWN["L"].y + 1)
    end)

    it("UpdateMatrices", function()
       for i = 0, board.width - 1, 1 do
           for j = 0, board.height - 1, 1 do
               assert.are.equal(board.boardTetrominosMatrix[i][j], 0)
           end
       end

       table.insert(board.boardTetrominoSquares,
            Square:new(Point:new(0, 0), colors.ASH))
       board:updateMatrices()
       assert.are.equal(board.boardTetrominosMatrix[0][0], 1)
    end)

    it("HoldCurrentTetromino", function()
        assert.is_nil(board.heldTetromino)
        assert.is_true(board.holdable)

        -- hold current tetromino and verify value
        currentTetromino = board.currentTetromino
        board:holdCurrentTetromino()
        assert.are.same(board.heldTetromino, currentTetromino)

        -- tetromino not dropped so holding it should not be allowed
        board:holdCurrentTetromino()
        -- held tetromino should be the same
        assert.is_false(board.holdable)
        assert.are.same(board.heldTetromino, currentTetromino)

        -- drop tetromino and hold tetromino
        nextTetromino = board.nextTetromino
        board.movement:hardDrop()
        board:holdCurrentTetromino()
        -- held tetromino should swap with current tetromino
        assert.are.same(board.heldTetromino, nextTetromino)
        assert.are.same(board.currentTetromino, currentTetromino)

        -- test held tetromino position gets reset if moved before holding
        board.currentTetromino:offset(-1, 0)
        board:holdCurrentTetromino()
        board.movement:hardDrop()
        board:holdCurrentTetromino()
        -- tetromino position should equal spawn position
        assert.are.same(board.currentTetromino.origin,
            properties.SPAWN[nextTetromino.id])
    end)
end)
