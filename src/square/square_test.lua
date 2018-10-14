local Square = require("src/square/square")
local Point = require("src/point/point")
local colors = require("src/colors/colors")

describe("#Square", function() -- tagged as "Square"
    it("Constructor", function()
        for i = 0, 9, 1 do
            for j = 0, 21, 1 do
                square = Square:new(Point:new(i, j), colors.ASH)
                assert.are.equal(square.x, i)
                assert.are.equal(square.y, j)
                assert.are.equal(square.color, colors.ASH)
            end
        end
    end)

    it("Offset", function()
        offsets = {
            {1, 0},
            {-1, 0},
            {0, 1},
            {0, -1}
        }

        for _, offset in pairs(offsets) do
            for i = 0, 9, 1 do
                for j = 0, 21, 1 do
                    square = Square:new(Point:new(i, j), colors.ASH)
                    square:offset(offset[1], offset[2])
                    assert.are.equal(square.x, i + offset[1])
                    assert.are.equal(square.y, j + offset[2])
                end
            end
        end
    end)
end)
