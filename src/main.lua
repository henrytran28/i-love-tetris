local Board = require("board/board")
local constants = require("constants")
local Tetrion = require("tetrion/tetrion")

love.window.setMode(constants.WINDOW_WIDTH, constants.WINDOW_HEIGHT, nil)

board = Board:new(10, 22)
tetrion = Tetrion:new(board)

require("love/draw")
require("love/update")
require("love/keypress")
