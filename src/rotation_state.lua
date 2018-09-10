local RotationState = {}

function RotationState:new()
    local rs = {value = 0}
    self.__index = self
    setmetatable(rs, self)
    return rs
end

function RotationState:increment()
    self.value = (self.value + 1) % 4
end

function RotationState:decrement()
    self.value = (self.value - 1) % 4
end

function RotationState:next()
    return (self.value + 1) % 4
end

function RotationState:prev()
    return (self.value - 1) % 4
end

return RotationState