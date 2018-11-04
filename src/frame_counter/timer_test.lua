local FrameCounter = require("frame_counter/frame_counter")

describe("#FrameCounter", function() -- tagged as "FrameCounter"
    before_each(function()
        frameCounter = FrameCounter:new(1)
    end)

    it("Constructor", function()
        assert.are.equal(0, frameCounter.elapsedFrames)
        assert.are.equal(1, frameCounter.maxFrames)
    end)

    it("Add and Subtract", function()
        frameCounter:add(1)
        assert.are.equal(1, frameCounter.elapsedFrames)
        frameCounter:add(1)
        assert.are.equal(2, frameCounter.elapsedFrames)
        frameCounter:subtract(2)
        assert.are.equal(0, frameCounter.elapsedFrames)
    end)

    it("Exceeds", function()
        frameCounter:add(1)
        assert.is_true(frameCounter:exceeds(0))
        assert.is_false(frameCounter:exceeds(2))
    end)

    it("Reset", function()
        frameCounter:add(1)
        frameCounter:reset()
        assert.are.equal(0, frameCounter.elapsedFrames)
    end)
end)
