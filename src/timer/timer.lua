local Timer = {}

function Timer:new(value, max)
    local timer = {
        value = value,
        max = max,
    }
    self.__index = self
    setmetatable(timer, self)
    return timer
end

function Timer:add(dt)
    self.value = self.value + dt
end

function Timer:subtract(dt)
    self.value = self.value - dt
end

function Timer:exceeds(time)
    return self.value >= time
end

function Timer:reset()
    self.value = 0
end

return Timer
