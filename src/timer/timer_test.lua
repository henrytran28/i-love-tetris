
local Timer = require("timer/timer")

describe("#Timer", function() -- tagged as "Timer"
    before_each(function()
        timer = Timer:new()
    end)

    it("Constructor", function()
        assert.are.equal(0, timer.value)
    end)

    it("Add and Subtract", function()
        timer:add(1)
        assert.are.equal(1, timer.value)
        timer:add(1)
        assert.are.equal(2, timer.value)
        timer:subtract(2)
        assert.are.equal(0, timer.value)
    end)

    it("Exceeds", function()
        timer:add(1)
        assert.is_true(timer:exceeds(0))
        assert.is_false(timer:exceeds(2))
    end)

    it("Reset", function()
        timer:add(1)
        timer:reset()
        assert.are.equal(0, timer.value)
    end)
end)
