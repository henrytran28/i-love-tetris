local Matrix = require("board/matrix")

describe("#Matrix", function() -- tagged as "Matrix"
    local matrix

    before_each(function()
        matrix = Matrix:new(10, 22)
    end)

    it("Constructor", function()
        for i = 0, 9, 1 do
            for j = 0, 21, 1 do
                assert.are.equal(0, matrix[i][j])
            end
        end
        assert.are.equal(matrix.width, 10)
        assert.are.equal(matrix.height, 22)
    end)

    it("Fill", function()
        for i = 0, 9, 1 do
            for j = 0, 21, 1 do
                matrix:fill(i, j)
                assert.are.same(matrix[i][j], 1)
            end
        end
    end)

    it("Unfill", function()
        for i = 0, 9, 1 do
            for j = 0, 21, 1 do
                matrix:fill(i, j)
                matrix:unfill(i, j)
                assert.are.same(matrix[i][j], 0)
            end
        end
    end)

    it("IsFilled", function()
        for i = 0, 9, 1 do
            for j = 0, 21, 1 do
                matrix:fill(i, j)
                assert.is_true(matrix:isFilled(i, j))
                matrix:unfill(i, j)
                assert.is_not_true(matrix:isFilled(i, j))
            end
        end
    end)

    it("GetFilledIndices", function()
        filledIndices = {0, 1, 2, 3, 4, 5, 6}
        assert.is.falsy(next(matrix:getFilledIndices()))
        for i = 0, 9, 1 do
            for j = 0, 6, 1 do
                matrix:fill(i, j)
            end
        end
        assert.are.same(matrix:getFilledIndices(), filledIndices)
    end)

    it("Clear", function()
        for i = 0, 9, 1 do
            for j = 0, 21, 1 do
                matrix:fill(i, j)
            end
        end
        matrix:clear()
        for i = 0, 9, 1 do
            for j = 0, 21, 1 do
                assert(matrix[i][j], 0)
            end
        end
    end)
end)
