local properties = require("properties")
local Tetromino = require("tetromino")

local Randomizer = {
    list = {}
}

function Randomizer:newList()
    local list = {}
    for key in pairs(properties.LAYOUTS) do
        table.insert(list, key)
    end

    local shuffled = {}
    math.randomseed(os.time())
    for i = #list, 1, -1 do
        local j = math.random(i)
        list[i], list[j] = list[j], list[i]
        table.insert(shuffled, list[i])
    end
    self.list = shuffled
end

function Randomizer:next()
    if #self.list == 0 then
        self:newList()
    end
    nextTetrominoId = table.remove(self.list, 1)
    return Tetromino:new(
        nextTetrominoId,
        properties.SPAWN[nextTetrominoId],
        properties.COLORS[nextTetrominoId]
    )
end

return Randomizer
