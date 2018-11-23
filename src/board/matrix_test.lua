local Matrix = require("board/matrix")
local colors = require("colors/colors")

describe("#Matrix", function() -- tagged as "Matrix"
    before_each(function()
        matrix = Matrix:new(10, 22)
    end)

    it("Constructor", function()
        for x = 0, 9, 1 do
            for y = 0, 21, 1 do
                assert.are.equal(0, matrix[x][y])
            end
        end
        assert.are.equal(matrix.width, 10)
        assert.are.equal(matrix.height, 22)
    end)

    it("Fill", function()
        for x = 0, 9, 1 do
            for y = 0, 21, 1 do
                matrix:fill(x, y, colors.ASH)
                assert.are.same(matrix[x][y], colors.ASH)
            end
        end
    end)

    it("Unfill", function()
        for x = 0, 9, 1 do
            for y = 0, 21, 1 do
                matrix:fill(x, y, colors.ASH)
                matrix:unfill(x, y)
                assert.are.same(matrix[x][y], 0)
            end
        end
    end)

    it("IsFilled", function()
        for x = 0, 9, 1 do
            for y = 0, 21, 1 do
                matrix:fill(x, y, colors.ASH)
                assert.is_true(matrix:isFilled(x, y))
                matrix:unfill(x, y)
                assert.is_not_true(matrix:isFilled(x, y))
            end
        end
    end)
end)
