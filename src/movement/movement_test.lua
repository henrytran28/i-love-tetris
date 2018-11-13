local Movement = require("movement/movement")
local Board = require("board/board")
local Tetromino = require("tetromino/tetromino")
local properties = require("tetromino/properties")
local Point = require("point/point")
local Square = require("square/square")

describe("#Movement", function() -- tagged as "Movement"
    before_each(function()
        movement = Movement:init(Board:new(10, 22))
        ids = {"O", "I", "J", "L", "S", "Z", "T"}
    end)

    it("Constructor", function()
        assert.is_truthy(movement.board)
    end)


    it("moveLeft", function()
        for _, id in pairs(ids) do
            -- Test moveLeft against edge of the board
            movement.board.currentTetromino = Tetromino:new(id, properties.SPAWN[id], properties.COLORS[id])
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
            movement.board.currentTetromino = Tetromino:new(id, Point:new(7, 0), properties.COLORS[id])
            movement:moveLeft() -- moves 1 cell to the left
            assert.are_same(Point:new(6, 0), movement.board.currentTetromino.origin)
            movement:moveLeft() -- blocked by occupied square
            assert.are_same(Point:new(6, 0), movement.board.currentTetromino.origin)
            movement.board.boardTetrominoSquares = {}
        end
    end)
end)
