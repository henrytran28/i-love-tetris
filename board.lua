local colors = require("colors")

local Board = {width = 10, height = 22}

function Board:render()
    self:renderBackground()
end

function Board:renderBackground()
    for i = 0, self.width, 1 do
        for j = 0, self.height, 1 do
            if (i % 2 == 0 and j % 2 == 0) or
               ((i + 1) % 2 == 0 and (j + 1) % 2 == 0) then
                love.graphics.setColor(colors.CHARCOAL)
            else
                love.graphics.setColor(colors.JET)
            end
            love.graphics.rectangle("fill", i * unit, j * unit, unit, unit)
        end
    end
end

return Board