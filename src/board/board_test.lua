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
        assert.are.equal(10, board.width)
        assert.are.equal(22, board.height)
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

        assert.are_equal(4, ghostSquares[1].x)
        assert.are_equal(0, ghostSquares[1].y)
        assert.are_equal(5, ghostSquares[2].x)
        assert.are_equal(0, ghostSquares[2].y)
        assert.are_equal(5, ghostSquares[3].x)
        assert.are_equal(1, ghostSquares[3].y)
        assert.are_equal(4, ghostSquares[4].x)
        assert.are_equal(1, ghostSquares[4].y)
    end)

    it("CycleNextTetromino", function()
        for i = 0, 99, 1 do
            lastTetrominoID = board.currentTetromino.id
            board:cycleNextTetromino()
            if i + 1 % 7 ~= 0 then
                assert.are_not.equal(lastTetrominoID,
                    board.currentTetromino.id)
            end
        end
    end)

    it("CheckOverlappingSpawn", function()
        board.boardTetrominosMatrix:fill(5, 19)
        board.boardTetrominosMatrix:fill(6, 19)
        board.boardTetrominosMatrix:fill(6, 20)
        board.currentTetromino = Tetromino:new("L", properties.SPAWN["L"], colors.ASH)
        board:checkOverlappingSpawn()
        assert.are_equal(properties.SPAWN["L"].x, board.currentTetromino.origin.x)
        assert.are_equal(properties.SPAWN["L"].y + 1, board.currentTetromino.origin.y)
    end)

    it("UpdateMatrices", function()
       for i = 0, board.width - 1, 1 do
           for j = 0, board.height - 1, 1 do
               assert.are.equal(0, board.boardTetrominosMatrix[i][j])
           end
       end

       table.insert(board.boardTetrominoSquares,
            Square:new(Point:new(0, 0), colors.ASH))
       board:updateMatrices()
       assert.are.equal(1, board.boardTetrominosMatrix[0][0])
    end)

    it("HoldCurrentTetromino", function()
        assert.is_nil(board.heldTetromino)
        assert.is_true(board.holdable)

        -- hold current tetromino and verify value
        currentTetromino = board.currentTetromino
        board:holdCurrentTetromino()
        assert.are.same(currentTetromino, board.heldTetromino)

        -- tetromino not dropped so holding it should not be allowed
        board:holdCurrentTetromino()
        -- held tetromino should be the same
        assert.is_false(board.holdable)
        assert.are.same(currentTetromino, board.heldTetromino)

        -- drop tetromino and hold tetromino
        nextTetromino = board.nextTetromino
        board.movement:hardDrop()
        board:holdCurrentTetromino()
        -- held tetromino should swap with current tetromino
        assert.are.same(nextTetromino, board.heldTetromino)
        assert.are.same(currentTetromino, board.currentTetromino)

        -- test held tetromino position gets reset if moved before holding
        board.currentTetromino:offset(-1, 0)
        board:holdCurrentTetromino()
        board.movement:hardDrop()
        board:holdCurrentTetromino()
        -- tetromino position should equal spawn position
        assert.are.same(properties.SPAWN[nextTetromino.id],
            board.currentTetromino.origin)
    end)

    it("GetTetrominoSquareIndex", function()
        board.currentTetromino = Tetromino:new("J", properties.SPAWN["J"], colors.ASH)
        board.movement:hardDrop()
        assert.are_equal(1, board:getTetrominoSquareIndex(board.boardTetrominoSquares, 3, 0))
        assert.are_equal(2, board:getTetrominoSquareIndex(board.boardTetrominoSquares, 4, 0))
        assert.are_equal(3, board:getTetrominoSquareIndex(board.boardTetrominoSquares, 5, 0))
        assert.are_equal(4, board:getTetrominoSquareIndex(board.boardTetrominoSquares, 3, 1))
    end)

    it("ClearLines", function()
        -- testing multiple lines cleared
        for i = 0, 9, 1 do
            table.insert(board.boardTetrominoSquares, Square:new(Point:new(i, 3), colors.ASH))
            table.insert(board.boardTetrominoSquares, Square:new(Point:new(i, 8), colors.ASH))
        end

        board:updateMatrices()
        local filledIndices = board.boardTetrominosMatrix:getFilledIndices()
        board:clearLines(filledIndices)
        board:updateMatrices()

        for i = 0, 9, 1 do
            assert.is_false(board.boardTetrominosMatrix:isFilled(i, 3))
            assert.is_false(board.boardTetrominosMatrix:isFilled(i, 8))
        end

        -- testing that not filled line is left alone
        for i = 0, 7, 1 do
            table.insert(board.boardTetrominoSquares,
                Square:new(Point:new(i, 2), colors.ASH))
        end

        board:updateMatrices()
        filledIndices = board.boardTetrominosMatrix:getFilledIndices()
        assert.is.falsy(next(filledIndices))

        for i = 0, 7, 1 do
            assert.is_true(board.boardTetrominosMatrix:isFilled(i, 2))
        end
        assert.is_false(board.boardTetrominosMatrix:isFilled(8, 2))
        assert.is_false(board.boardTetrominosMatrix:isFilled(9, 2))
    end)

    it("DropLines", function()
        -- testing single line drop
        for i = 0, 9, 1 do
            table.insert(board.boardTetrominoSquares,
                Square:new(Point:new(i, 0), colors.ASH))
        end
        -- add in squares to be dropped down
        table.insert(board.boardTetrominoSquares, Square:new(Point:new(0, 1), colors.ASH))
        table.insert(board.boardTetrominoSquares, Square:new(Point:new(1, 1), colors.ASH))
        table.insert(board.boardTetrominoSquares, Square:new(Point:new(2, 1), colors.ASH))

        board:updateMatrices()
        local filledIndices = board.boardTetrominosMatrix:getFilledIndices()
        board:clearLines(filledIndices)
        board:dropLines(filledIndices)
        board:updateMatrices()

        for i = 0, 2, 1 do
            assert.is_true(board.boardTetrominosMatrix:isFilled(i, 0))
        end
        for i = 3, 9, 1 do
            assert.is_false(board.boardTetrominosMatrix:isFilled(i, 0))
        end

        -- testing multiple line drop
        for i = 0, 9, 1 do
            table.insert(board.boardTetrominoSquares, Square:new(Point:new(i, 0), colors.ASH))
            table.insert(board.boardTetrominoSquares, Square:new(Point:new(i, 2), colors.ASH))
        end
        table.insert(board.boardTetrominoSquares, Square:new(Point:new(0, 1), colors.ASH))
        table.insert(board.boardTetrominoSquares, Square:new(Point:new(1, 1), colors.ASH))
        table.insert(board.boardTetrominoSquares, Square:new(Point:new(2, 1), colors.ASH))
        table.insert(board.boardTetrominoSquares, Square:new(Point:new(0, 3), colors.ASH))
        table.insert(board.boardTetrominoSquares, Square:new(Point:new(1, 3), colors.ASH))

        board:updateMatrices()
        filledIndices = board.boardTetrominosMatrix:getFilledIndices()
        board:clearLines(filledIndices)
        board:dropLines(filledIndices)
        board:updateMatrices()

        for i = 0, 2, 1 do
            assert.is_true(board.boardTetrominosMatrix:isFilled(i, 0))
        end
        for i = 3, 9, 1 do
            assert.is_false(board.boardTetrominosMatrix:isFilled(i, 0))
        end

        for i = 0, 1, 1 do
            assert.is_true(board.boardTetrominosMatrix:isFilled(i, 1))
        end
        for i = 2, 9, 1 do
            assert.is_false(board.boardTetrominosMatrix:isFilled(i, 1))
        end
    end)
end)
