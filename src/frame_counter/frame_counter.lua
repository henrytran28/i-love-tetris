local FrameCounter = {}

function FrameCounter:new(maxFrames)
    local frameCounter = {
        elapsedFrames = 0,
        maxFrames = maxFrames,
    }
    self.__index = self
    setmetatable(frameCounter, self)
    return frameCounter
end

function FrameCounter:add(dt)
    self.elapsedFrames = self.elapsedFrames + dt
end

function FrameCounter:subtract(dt)
    self.elapsedFrames = self.elapsedFrames - dt
end

function FrameCounter:exceeds(time)
    return self.elapsedFrames >= time
end

function FrameCounter:reset()
    self.elapsedFrames = 0
end

return FrameCounter
