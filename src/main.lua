require("src/keyboard/keyboard")

local Board = require("src/board/board")

unit = 40
width = Board.width * unit
height = (Board.height - 2) * unit
love.window.setMode(width, height, nil)

function love.draw()
    Board:render()
end
