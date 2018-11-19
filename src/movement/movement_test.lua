local Movement = require("movement/movement")
local Board = require("board/board")
local Tetromino = require("tetromino/tetromino")
local properties = require("tetromino/properties")
local Point = require("point/point")
local Square = require("square/square")
local colors = require("colors/colors")

function getTetrominoWidth(tetromino)
    leftmost = 10
    rightmost = 0
    for _, square in pairs(tetromino.squares) do
        if square.x < leftmost then
            leftmost = square.x
        end
        if square.x > rightmost then
            rightmost = square.x
        end
    end
    return rightmost + 1 - leftmost
end

function getTetrominoHeight(tetromino)
    topmost = 0
    bottommost = 22
    for _, square in pairs(tetromino.squares) do
        if square.y < bottommost then
            bottommost = square.y
        end
        if square.y > topmost then
            topmost = square.y
        end
    end
    return topmost + 1 - bottommost
end

describe("#Movement", function() -- tagged as "Movement"
    before_each(function()
        movement = Movement:init(Board:new(10, 22))
        ids = {"O", "I", "J", "L", "S", "Z", "T"}
    end)

    it("Constructor", function()
        assert.is_truthy(movement.board)
    end)

    it("getTetrominoWidth", function()
        local widthsAtEachRotationState = {
            O = {2, 2, 2, 2},
            I = {4, 1, 4, 1},
            J = {3, 2, 3, 2},
            L = {3, 2, 3, 2},
            S = {3, 2, 3, 2},
            Z = {3, 2, 3, 2},
            T = {3, 2, 3, 2},
        }
        for id, vals in pairs(widthsAtEachRotationState) do
            tetromino = Tetromino:new(id, properties.SPAWN[id], properties.COLORS[id])
            for i = 1, #vals do
                assert.are_equal(vals[i], getTetrominoWidth(tetromino))
                tetromino:rotateCw()
            end
        end
    end)

    it("getTetrominoHeight", function()
        local heightsAtEachRotationState = {
            O = {2, 2, 2, 2},
            I = {1, 4, 1, 4},
            J = {2, 3, 2, 3},
            L = {2, 3, 2, 3},
            S = {2, 3, 2, 3},
            Z = {2, 3, 2, 3},
            T = {2, 3, 2, 3},
        }
        for id, vals in pairs(heightsAtEachRotationState) do
            tetromino = Tetromino:new(id, properties.SPAWN[id], properties.COLORS[id])
            for i = 1, #vals do
                assert.are_equal(vals[i], getTetrominoHeight(tetromino))
                tetromino:rotateCw()
            end
        end
    end)

    it("moveLeft", function()
        for _, id in pairs(ids) do
            -- Test moveLeft against edge of the board
            movement.board.currentTetromino = Tetromino:new(id, properties.SPAWN[id], properties.COLORS[id])
            tetrominoWidth = getTetrominoWidth(movement.board.currentTetromino)
            spawnPosition = movement.board.currentTetromino.origin
            for i = 1, spawnPosition.x do
                movement:moveLeft()
                assert.are_same(
                    Point:new(spawnPosition.x - i, spawnPosition.y),
                    movement.board.currentTetromino.origin
                )
            end
            assert.are_same(Point:new(0, spawnPosition.y), movement.board.currentTetromino.origin)
            movement:moveLeft() -- already at edge, shouldn't move
            assert.are_same(Point:new(0, spawnPosition.y), movement.board.currentTetromino.origin)

            -- Test moveLeft against occupied squares
            table.insert(movement.board.boardTetrominoSquares, Square:new(Point:new(5, 0)))
            table.insert(movement.board.boardTetrominoSquares, Square:new(Point:new(5, 1)))
            movement.board:updateMatrices()

            movement.board.currentTetromino = Tetromino:new(
                id,
                Point:new(movement.board.width - tetrominoWidth, 0),
                properties.COLORS[id]
            )
            for i = 1, (movement.board.currentTetromino.origin.x - 1) - 5 do
                movement:moveLeft()
            end
            assert.are_same(Point:new(6, 0), movement.board.currentTetromino.origin)
            movement:moveLeft() -- blocked by occupied squares
            assert.are_same(Point:new(6, 0), movement.board.currentTetromino.origin)
            movement.board.boardTetrominoSquares = {}
        end
    end)

    it("moveRight", function()
        for _, id in pairs(ids) do
            -- Test moveRight against edge of the board
            movement.board.currentTetromino = Tetromino:new(id, properties.SPAWN[id], properties.COLORS[id])
            spawnPosition = movement.board.currentTetromino.origin
            tetrominoWidth = getTetrominoWidth(movement.board.currentTetromino)
            for i = 1, movement.board.width - (spawnPosition.x + tetrominoWidth) do
                movement:moveRight()
                assert.are_same(
                    Point:new(spawnPosition.x + i, spawnPosition.y),
                    movement.board.currentTetromino.origin
                )
            end
            assert.are_same(
                Point:new(movement.board.width - tetrominoWidth, properties.SPAWN[id].y),
                movement.board.currentTetromino.origin
            )
            movement:moveRight() -- already at edge, shouldn't move
            assert.are_same(
                Point:new(movement.board.width - tetrominoWidth, properties.SPAWN[id].y),
                movement.board.currentTetromino.origin
            )

            -- Test moveRight against occupied squares
            table.insert(movement.board.boardTetrominoSquares, Square:new(Point:new(5, 0)))
            table.insert(movement.board.boardTetrominoSquares, Square:new(Point:new(5, 1)))
            movement.board:updateMatrices()
            movement.board.currentTetromino = Tetromino:new(id, Point:new(0, 0), properties.COLORS[id])

            for i = 1, 5 - tetrominoWidth do
                movement:moveRight()
            end
            assert.are_same(Point:new(5 - tetrominoWidth, 0), movement.board.currentTetromino.origin)
            movement:moveRight() -- blocked by occupied squares
            assert.are_same(Point:new(5 - tetrominoWidth, 0), movement.board.currentTetromino.origin)
            movement.board.boardTetrominoSquares = {}
        end
    end)

    it("moveDown", function()
        for _, id in pairs(ids) do
            -- Test moveDown against edge of the board
            movement.board.currentTetromino = Tetromino:new(id, properties.SPAWN[id], properties.COLORS[id])
            spawnPosition = movement.board.currentTetromino.origin
            tetrominoHeight = getTetrominoHeight(movement.board.currentTetromino)
            for i = 1, spawnPosition.y do
                movement:moveDown()
                assert.are_same(Point:new(spawnPosition.x, spawnPosition.y - i), movement.board.currentTetromino.origin)
            end
            assert.are_same(Point:new(spawnPosition.x, 0), movement.board.currentTetromino.origin)
            movement:moveDown() -- already at edge, shouldn't move
            assert.are_same(Point:new(spawnPosition.x, 0), movement.board.currentTetromino.origin)

            -- Test moveDown against occupied squares
            table.insert(movement.board.boardTetrominoSquares, Square:new(Point:new(4, 5)))
            table.insert(movement.board.boardTetrominoSquares, Square:new(Point:new(5, 5)))
            movement.board:updateMatrices()
            movement.board.currentTetromino = Tetromino:new(id, Point:new(4, 8), properties.COLORS[id])
            for i = 1, 2 do
                movement:moveDown()
            end
            assert.are_same(Point:new(4, 6), movement.board.currentTetromino.origin)
            movement:moveDown() -- blocked by occupied squares
            assert.are_same(Point:new(4, 6), movement.board.currentTetromino.origin)
            movement.board.boardTetrominoSquares = {}
        end
    end)

    it("moveUp", function()
        for _, id in pairs(ids) do
            -- Test moveUp against edge of the board
            movement.board.currentTetromino = Tetromino:new(id, Point:new(3, 17), properties.COLORS[id])
            spawnPosition = movement.board.currentTetromino.origin
            tetrominoHeight = getTetrominoHeight(movement.board.currentTetromino)
            cellsToMove = movement.board.height - (spawnPosition.y + tetrominoHeight)
            for i = 1, cellsToMove do
                movement:moveUp()
                assert.are_same(
                    Point:new(spawnPosition.x, spawnPosition.y + i),
                    movement.board.currentTetromino.origin
                )
            end
            assert.are_same(
                Point:new(spawnPosition.x, movement.board.height - tetrominoHeight),
                movement.board.currentTetromino.origin
            )
            movement:moveUp() -- already at edge, shouldn't move
            assert.are_same(
                Point:new(spawnPosition.x, movement.board.height - tetrominoHeight),
                movement.board.currentTetromino.origin
            )
            -- Test moveUp against occupied squares
            table.insert(movement.board.boardTetrominoSquares, Square:new(Point:new(4, 5)))
            table.insert(movement.board.boardTetrominoSquares, Square:new(Point:new(5, 5)))
            table.insert(movement.board.boardTetrominoSquares, Square:new(Point:new(6, 5)))
            movement.board:updateMatrices()
            movement.board.currentTetromino = Tetromino:new(id, Point:new(4, 0), properties.COLORS[id])
            for i = 1, 5 - tetrominoHeight do
                movement:moveUp()
            end
            assert.are_same(Point:new(4, 5 - tetrominoHeight), movement.board.currentTetromino.origin)
            movement:moveUp() -- blocked by occupied squares
            assert.are_same(Point:new(4, 5 - tetrominoHeight), movement.board.currentTetromino.origin)
            movement.board.boardTetrominoSquares = {}
        end
    end)

    it("hardDrop", function()
        for _, id in pairs(ids) do
            -- initialize some variables
            movement.board.holdable = false
            movement.board.gravityFrameCounter:add(10)
            movement.board.expirationFrameCounter:add(10)

            -- check currentTetromino drops to the bottom of the board
            movement.board.currentTetromino = Tetromino:new(id, properties.SPAWN[id], properties.COLORS[id])
            finalPosition = Point:new(movement.board.currentTetromino.origin.x, 0)
            -- make sure the final square positions are not filled yet
            for _, layout in pairs(properties.LAYOUTS[id]) do
                point = sum(finalPosition, layout)
                assert.is_false(movement.board.boardTetrominosMatrix:isFilled(point.x, point.y))
            end
            movement:hardDrop()
            -- after the drop the same square positions should be filled
            for _, layout in pairs(properties.LAYOUTS[id]) do
                point = sum(finalPosition, layout)
                assert.is_true(movement.board.boardTetrominosMatrix:isFilled(point.x, point.y))
            end
            -- check variables have reset
            assert.is_true(movement.board.holdable)
            assert.are_equal(0, movement.board.gravityFrameCounter.elapsedFrames)
            assert.are_equal(0, movement.board.expirationFrameCounter.elapsedFrames)

            -- reset the board for the next iteration
            movement.board.boardTetrominoSquares = {}
            movement.board:updateMatrices()
        end
    end)

    it("wallKickTestPass", function()
        for _, id in pairs(ids) do
            -- no offset, the test should pass
            movement.board.currentTetromino = Tetromino:new(id, properties.SPAWN[id], colors.ASH)
            assert.is_true(movement:wallKickTestPass(0, 0))

            -- test an offset that should pass
            assert.is_true(movement:wallKickTestPass(0, -1))

            -- check against the walls
            movement.board.currentTetromino = Tetromino:new(id, Point:new(0, 0), colors.ASH)
            assert.is_false(movement:wallKickTestPass(-1, 0))
            assert.is_false(movement:wallKickTestPass(0, -1))
            movement.board.currentTetromino = Tetromino:new(
                id,
                Point:new(
                    movement.board.width - getTetrominoWidth(movement.board.currentTetromino),
                    movement.board.height - getTetrominoHeight(movement.board.currentTetromino)),
                colors.ASH
            )
            assert.is_false(movement:wallKickTestPass(1, 0))
            assert.is_false(movement:wallKickTestPass(0, 1))

            -- check against filled squares
            table.insert(movement.board.boardTetrominoSquares, Square:new(Point:new(5, 0), colors.ASH))
            table.insert(movement.board.boardTetrominoSquares, Square:new(Point:new(5, 1), colors.ASH))
            movement.board:updateMatrices()
            movement.board.currentTetromino = Tetromino:new(
                id,
                Point:new(5 - getTetrominoWidth(movement.board.currentTetromino), 0),
                colors.ASH
            )
            assert.is_false(movement:wallKickTestPass(1, 0))
        end
    end)
end)
