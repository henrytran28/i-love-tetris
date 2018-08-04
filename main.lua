local Board = require("board")
local Square = require("square")
local Tetromino = require("tetromino")
local colors = require("colors")
local Point = require("point")

unit = 40
width = 10 * unit
height = 22 * unit
love.window.setMode(width, height, nil)

tetromino = Tetromino:new(nil, nil, colors.TEAL)

function love.draw()
    Board:render()
    tetromino:render()
end