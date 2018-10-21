local Timer = {}

function Timer:new()
    local timer = {value = 0}
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

function Timer:reset()
    self.value = 0
end

function Timer.calculateTime(timeAtMin, timeAtMax, percentSetting)
    return ((timeAtMax - timeAtMin) / 100) * percentSetting + timeAtMin
end

return Timer
