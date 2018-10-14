local Randomizer = require("src/randomizer/randomizer")

describe("#Randomizer", function() -- tagged as "Randomizer"
    it("New List", function()
        assert.are.equal(#Randomizer.list, 0)
        Randomizer:newList()
        assert.are.equal(#Randomizer.list, 7)
        expectedIds = {"O", "I", "J", "L", "S", "Z", "T"}
        for _, id in pairs(expectedIds) do
            idExists = false
            for _, item in pairs(Randomizer.list) do
                if id == item then
                    idExists = true
                end
            end
            assert.is_true(idExists)
        end
    end)

    it("Next", function() 
        for i = 7, 1, -1 do
            tetromino = Randomizer:next()
            idExists = false
            for _, item in pairs(Randomizer.list) do
                if tetromino.id == item then
                    idExists = true
                end
            end
            assert.not_true(idExists)
            assert.are.equal(#Randomizer.list, i - 1)
        end
        Randomizer:next()
        assert.are.equal(#Randomizer.list, 6)
    end)
end)
