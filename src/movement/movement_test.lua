local Movement = require("movement/movement")
local Board = require("board/board")
local Tetromino = require("tetromino/tetromino")
local properties = require("tetromino/properties")
local Point = require("point/point")
local Square = require("square/square")
local inspect = require("inspect")

function getTetrominoWidth(tetromino)
    leftmost = 22
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
            for i = 1, #vals, 1 do
                assert.are_equal(vals[i], getTetrominoWidth(tetromino))
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
            for i = 0, properties.SPAWN[id].x - 1, 1 do
                movement:moveLeft()
                assert.are_same(
                    Point:new(spawnPosition.x - (i + 1), spawnPosition.y),
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
            for i = 1, (movement.board.currentTetromino.origin.x - 1) - 5, 1 do
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
            for i = 0, (movement.board.width - 1) - properties.SPAWN[id].x - tetrominoWidth, 1 do
                movement:moveRight()
                assert.are_same(
                    Point:new(spawnPosition.x + (i + 1), spawnPosition.y),
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

            for i = 1, 5 - tetrominoWidth, 1 do
                movement:moveRight()
            end
            assert.are_same(Point:new(5 - tetrominoWidth, 0), movement.board.currentTetromino.origin)
            movement:moveRight() -- blocked by occupied squares
            assert.are_same(Point:new(5 - tetrominoWidth, 0), movement.board.currentTetromino.origin)
            movement.board.boardTetrominoSquares = {}
        end
    end)
end)
