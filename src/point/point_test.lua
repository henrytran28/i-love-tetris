local Point = require("point")

describe("#Point", function()
    it("Constructor", function()
        for i = 0, 9, 1 do
            point = Point:new(i, j)
            assert.are.equal(point.x, i)
            assert.are.equal(point.y, j)
        end
    end)

	it("sum", function()
        pointsList = {
            Point:new(-1, 0),
            Point:new(1, 0),
            Point:new(0, -1),
            Point:new(0, 1)
        }
        for i = 0, 9, 1 do
            for j = 0, 21, 1 do
                for _, addPoint in pairs(pointsList) do
                    testPoint = Point:new(i, j)
                    assert.are.same(sum(testPoint, addPoint), Point:new(i + addPoint.x, j + addPoint.y))
                end
            end
        end
    end)

    it("diff", function()
        pointsList = {
            Point:new(-1, 0),
            Point:new(1, 0),
            Point:new(0, -1),
            Point:new(0, 1)
        }
        for i = 0, 9, 1 do
            for j = 0, 21, 1 do
                for _, subPoint in pairs(pointsList) do
                    testPoint = Point:new(i, j)
                    assert.are.same(diff(testPoint, subPoint), Point:new(i - subPoint.x, j - subPoint.y))
                end
            end
        end
    end)
end)
