local Board = require("board/board")
local properties = require("tetromino/properties")
local Tetromino = require("tetromino/tetromino")
local Square = require("square/square")
local Point = require("point/point")
local colors = require("colors/colors")

describe("#Board", function() -- tagged as "Board"
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
        assert.are.equal(10, board.width)
        assert.are.equal(22, board.height)
        assert.is.truthy(board.boardTetrominosMatrix)
        assert.is.truthy(board.movement)
        assert.is.truthy(board.gravityFrameCounter)
        assert.is.truthy(board.expirationFrameCounter)
        assert.is_true(board.holdable)
        local ids = {"O", "I", "J", "L", "S", "Z", "T"}
        assert.is_true(tableContains(ids, board.currentTetromino.id))
        assert.is_true(tableContains(ids, board.nextTetromino.id))
        assert.is_true(tableContains(ids, board.ghostTetromino.id))
    end)

    it("GetGhostTetromino", function()
        board.currentTetromino = Tetromino:new("J", properties.SPAWN["J"],
            properties.COLORS["J"])
        board.ghostTetromino = board:getGhostTetromino()
        ghostSquares = board.ghostTetromino.squares

        -- default position
        assert.are_equal(3, ghostSquares[1].x)
        assert.are_equal(0, ghostSquares[1].y)
        assert.are_equal(4, ghostSquares[2].x)
        assert.are_equal(0, ghostSquares[2].y)
        assert.are_equal(5, ghostSquares[3].x)
        assert.are_equal(0, ghostSquares[3].y)
        assert.are_equal(3, ghostSquares[4].x)
        assert.are_equal(1, ghostSquares[4].y)

        -- add squares that have varying levels
        board.boardTetrominosMatrix:fill(5, 0, colors.ASH)
        board.boardTetrominosMatrix:fill(6, 0, colors.ASH)
        board.boardTetrominosMatrix:fill(7, 0, colors.ASH)
        board.boardTetrominosMatrix:fill(6, 1, colors.ASH)

        -- y position should have moved up by 1
        board.ghostTetromino = board:getGhostTetromino()
        ghostSquares = board.ghostTetromino.squares

        assert.are_equal(3, ghostSquares[1].x)
        assert.are_equal(1, ghostSquares[1].y)
        assert.are_equal(4, ghostSquares[2].x)
        assert.are_equal(1, ghostSquares[2].y)
        assert.are_equal(5, ghostSquares[3].x)
        assert.are_equal(1, ghostSquares[3].y)
        assert.are_equal(3, ghostSquares[4].x)
        assert.are_equal(2, ghostSquares[4].y)

        -- y position should have moved up by 1
        -- x position should have moved right by 1
        board.currentTetromino:offset(1, 0)
        board.ghostTetromino = board:getGhostTetromino()
        ghostSquares = board.ghostTetromino.squares

        assert.are_equal(4, ghostSquares[1].x)
        assert.are_equal(2, ghostSquares[1].y)
        assert.are_equal(5, ghostSquares[2].x)
        assert.are_equal(2, ghostSquares[2].y)
        assert.are_equal(6, ghostSquares[3].x)
        assert.are_equal(2, ghostSquares[3].y)
        assert.are_equal(4, ghostSquares[4].x)
        assert.are_equal(3, ghostSquares[4].y)

        -- rotate clockwise twice and move right by 3
        board.currentTetromino:offset(3, 0)
        board.currentTetromino:rotateCw()
        board.currentTetromino:rotateCw()
        board.ghostTetromino = board:getGhostTetromino()
        ghostSquares = board.ghostTetromino.squares

        assert.are_equal(9, ghostSquares[1].x)
        assert.are_equal(1, ghostSquares[1].y)
        assert.are_equal(8, ghostSquares[2].x)
        assert.are_equal(1, ghostSquares[2].y)
        assert.are_equal(7, ghostSquares[3].x)
        assert.are_equal(1, ghostSquares[3].y)
        assert.are_equal(9, ghostSquares[4].x)
        assert.are_equal(0, ghostSquares[4].y)
    end)

    it("CycleNextTetromino", function()
        for i = 0, 99, 1 do
            lastTetrominoID = board.currentTetromino.id
            board:cycleNextTetromino()
            assert.is.truthy(board.currentTetromino)
            assert.is.truthy(board.ghostTetromino)
            assert.is.truthy(board.nextTetromino)
            if (i + 1) % 7 ~= 0 then
                assert.are_not.equal(lastTetrominoID, board.currentTetromino.id)
            end
        end
    end)

    it("OffsetOverlappingTetromino", function()
        local ids = {"O", "I", "J", "L", "S", "Z", "T"}

        board.boardTetrominosMatrix:fill(5, 18)
        board.boardTetrominosMatrix:fill(6, 18)
        board.boardTetrominosMatrix:fill(6, 19)
        board.boardTetrominosMatrix:fill(6, 20)
        for _, id in pairs(ids) do
            board.currentTetromino = Tetromino:new(id, properties.SPAWN[id], properties.COLORS[id])
            board:offsetOverlappingTetromino(board.currentTetromino)
            expectedHeight = properties.SPAWN[id].y
            if id == "I" then
                expectedHeight = properties.SPAWN[id].y + 2
            end

            assert.are_equal(properties.SPAWN[id].x, board.currentTetromino.origin.x)
            assert.are_equal(expectedHeight, board.currentTetromino.origin.y)
        end
    end)

    it("IsOverlapping", function()
        board.boardTetrominosMatrix:fill(5, 18)
        tetromino = Tetromino:new("O", Point:new(0, 0), colors.ASH)
        assert.is_false(board:isOverlapping(tetromino))
        tetromino = Tetromino:new("O", Point:new(5, 18), colors.ASH)
        assert.is_true(board:isOverlapping(tetromino))
    end)

    it("IsGameOver", function()
        local ids = {"O", "I", "J", "L", "S", "Z", "T"}

        board.boardTetrominosMatrix:fill(5, 19, colors.ASH)
        board.boardTetrominosMatrix:fill(5, 20, colors.ASH)
        board.boardTetrominosMatrix:fill(5, 21, colors.ASH)

        for _, id in pairs(ids) do
            board.currentTetromino = Tetromino:new(id, properties.SPAWN[id], properties.COLORS[id])
            board:offsetOverlappingTetromino(board.currentTetromino)
            assert.is_true(board:isGameOver())
        end
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

    it("ClearLines", function()
        -- testing multiple lines cleared
        for i = 0, 9, 1 do
            board.boardTetrominosMatrix:fill(i, 3, colors.ASH)
            board.boardTetrominosMatrix:fill(i, 8, colors.ASH)
        end

        local filledIndices = board.boardTetrominosMatrix:getFilledIndices()
        board:clearLines(filledIndices)

        for i = 0, 9, 1 do
            assert.is_false(board.boardTetrominosMatrix:isFilled(i, 3))
            assert.is_false(board.boardTetrominosMatrix:isFilled(i, 8))
        end

        -- testing that not filled line is left alone
        for i = 0, 7, 1 do
            board.boardTetrominosMatrix:fill(i, 2, colors.ASH)
        end

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
            board.boardTetrominosMatrix:fill(i, 0, colors.ASH)
        end
        -- add in squares to be dropped down
        board.boardTetrominosMatrix:fill(0, 1, colors.ASH)
        board.boardTetrominosMatrix:fill(1, 1, colors.ASH)
        board.boardTetrominosMatrix:fill(2, 1, colors.ASH)

        local filledIndices = board.boardTetrominosMatrix:getFilledIndices()
        board:clearLines(filledIndices)
        board:dropLines(filledIndices)

        for i = 0, 2, 1 do
            assert.is_true(board.boardTetrominosMatrix:isFilled(i, 0))
        end
        for i = 3, 9, 1 do
            assert.is_false(board.boardTetrominosMatrix:isFilled(i, 0))
        end

        -- testing multiple lines dropped
        for i = 0, 9, 1 do
            board.boardTetrominosMatrix:fill(i, 0, colors.ASH)
            board.boardTetrominosMatrix:fill(i, 2, colors.ASH)
        end
        board.boardTetrominosMatrix:fill(0, 1, colors.ASH)
        board.boardTetrominosMatrix:fill(1, 1, colors.ASH)
        board.boardTetrominosMatrix:fill(2, 1, colors.ASH)
        board.boardTetrominosMatrix:fill(0, 3, colors.ASH)
        board.boardTetrominosMatrix:fill(1, 3, colors.ASH)

        filledIndices = board.boardTetrominosMatrix:getFilledIndices()
        board:clearLines(filledIndices)
        board:dropLines(filledIndices)

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

    it("ObstacleBelow", function()
        assert.is_false(board:obstacleBelow(board.currentTetromino.squares))

        -- testing to see if at the bottom of board
        board.currentTetromino:offset(0, -19)
        assert.is_true(board:obstacleBelow(board.currentTetromino.squares))

        -- add squares in the way and test if there is an obstacle below
        board.currentTetromino = board.nextTetromino
        board.boardTetrominosMatrix:fill(3, 0)
        board.boardTetrominosMatrix:fill(4, 0)
        board.boardTetrominosMatrix:fill(5, 0)
        board.boardTetrominosMatrix:fill(4, 1)

        board.currentTetromino:offset(0, -17)
        assert.is_true(board:obstacleBelow(board.currentTetromino.squares))
    end)

    it("HandleGravity", function()
        -- testing gravity timer
        assert.are_equal(0, board.gravityFrameCounter.elapsedFrames)
        board.gravityFrameCounter.maxFrames = 5
        currentTetrominoID = board.currentTetromino.id
        board:handleGravity(10)

        -- gravity timer should have reset and moved down one
        assert.are_equal(0, board.gravityFrameCounter.elapsedFrames)
        assert.are.equal(18, board.currentTetromino.origin.y)

        -- testing expiration timer
        assert.are_equal(0, board.expirationFrameCounter.elapsedFrames)
        board.expirationFrameCounter.maxFrames = 15
        board.currentTetromino = Tetromino:new("T", properties.SPAWN["T"], colors.ASH)
        board.currentTetromino:offset(0, -19)

        -- confirm that nothing is on board after offset
        assert.is_false(board.boardTetrominosMatrix:isFilled(3, 0))
        assert.is_false(board.boardTetrominosMatrix:isFilled(4, 0))
        assert.is_false(board.boardTetrominosMatrix:isFilled(5, 0))
        assert.is_false(board.boardTetrominosMatrix:isFilled(4, 1))

        -- if there is an obstacle below piece should hard drop after exceeds frames
        board:handleGravity(20)
        assert.is_true(board.boardTetrominosMatrix:isFilled(3, 0))
        assert.is_true(board.boardTetrominosMatrix:isFilled(4, 0))
        assert.is_true(board.boardTetrominosMatrix:isFilled(5, 0))
        assert.is_true(board.boardTetrominosMatrix:isFilled(4, 1))
        assert.are_equal(0, board.gravityFrameCounter.elapsedFrames)
    end)
end)
