local Action = {}

function Action:new(keys, funcStr)
    local action = {
        keys = keys,
        funcStr = funcStr
    }
    self.__index = self
    setmetatable(action, self)
    return action
end

return Action
