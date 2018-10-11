local Tetromino = require("src/tetromino/tetromino")
local colors = require("src/colors/colors")
local Point = require("src/point/point")
local RotationState = require("src/tetromino/rotation_state")
local properties = require("src/tetromino/properties")
local Square = require("src/square/square")

describe("#Tetromino", function() -- tagged as "Tetromino"
    it("Constructor", function()
        colorsList = {
            ["O"] = colors.YELLOW,
            ["I"] = colors.TEAL,
            ["J"] = colors.BLUE,
            ["L"] = colors.ORANGE,
            ["S"] = colors.GREEN,
            ["Z"] = colors.RED,
            ["T"] = colors.PURPLE,
        }

        for id, color in pairs(colorsList) do
            for i = 0, 9, 1 do
                for j = 0, 21, 1 do
                    tetromino = Tetromino:new(id, Point:new(i, j), color)
                    assert.are.equal(tetromino.id, id)
                    assert.are.same(tetromino.origin, Point:new(i, j))
                    assert.are.equal(tetromino.rotationState.value, 0)
                    assert.are.equal(tetromino.color, color)
                end
            end
        end
    end)

    it("Offset",function()
        offsets = {
            {1, 0},
            {-1, 0},
            {0, 1},
            {0, -1}
        }
        ids = {"O", "I", "J", "L", "S", "Z", "T"}

        for _, id in pairs(ids) do
            for _, offset in pairs(offsets) do
                for i = 0, 9, 1 do
                    for j = 0, 21, 1 do
                        tetromino = Tetromino:new(id, Point:new(i, j), properties.COLORS[id])
                        tetromino:offset(offset[1], offset[2])
                        assert.are.equal(tetromino.origin.x, i + offset[1])
                        assert.are.equal(tetromino.origin.y, j + offset[2])
                    end
                end
            end
        end
    end)

    expectedOffsetsPerRotation = {
        ["O"] = {{Point:new(0, 0), Point:new(1, 0), Point:new(1, 1), Point:new(0, 1)}, -- initial layout
                 {Point:new(0, 0), Point:new(1, 0), Point:new(1, 1), Point:new(0, 1)}, -- 1 cw rotation
                 {Point:new(0, 0), Point:new(1, 0), Point:new(1, 1), Point:new(0, 1)}, -- 2 cw rotations
                 {Point:new(0, 0), Point:new(1, 0), Point:new(1, 1), Point:new(0, 1)}, -- 3 cw rotations
                 {Point:new(0, 0), Point:new(1, 0), Point:new(1, 1), Point:new(0, 1)}}, -- initial layout
    }

    function tableContains(table, value)
        for i = 1, #table do
            if table[i] == value then return true end
        end
        return false
    end

    it("Clockwise Rotation", function()
        for id, expectedOffsets in pairs(expectedOffsetsPerRotation) do
            for i = 0, 9, 1 do
                for j = 0, 21, 1 do
                    tetromino = Tetromino:new(id, Point:new(i, j), properties.COLORS[id])
                    oldPosition = tetromino.origin
                    for numRotations, offsets in pairs(expectedOffsets) do
                        -- check if origin remained the same afer a rotation
                        assert.are.same(tetromino.origin, Point:new(oldPosition.x, oldPosition.y))

                        -- get a list of strings representing the tetromino's square's indices
                        actualLayouts = {} -- {(x1, y1), (x2, y2) ...}
                        for _, square in pairs(tetromino.squares) do
                            actualLayoutStr = "("..tostring(square.x)..", "..tostring(square.y)..")" -- (x, y)
                            table.insert(actualLayouts, actualLayoutStr)
                        end

                        -- iterate through each layout point defined above
                        for _, offset in pairs(offsets) do
                            -- calculate the expected resulting points using the offset, also in the form (x, y)
                            expectedPositionStr = "("..tostring(tetromino.origin.x + offset.x)..", "..tostring(tetromino.origin.y + offset.y)..")"
                            -- assert that the expected resulting points exist in actualLayouts
                            assert.True(tableContains(actualLayouts, expectedPositionStr))
                        end
                        -- check value of rotation state
                        assert.are.equal(tetromino.rotationState.value, (numRotations - 1) % 4)
                        -- rotate cw for the next loop
                        tetromino:rotateCw()
                    end
                end
            end
        end
    end)
end)
