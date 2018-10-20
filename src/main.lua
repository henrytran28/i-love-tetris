local Board = require("board/board")
local constants = require("constants")
local Tetrion = require("tetrion/tetrion")

board = Board:new(10, 22) -- singleton
tetrion = Tetrion:new(board) -- singleton

love.window.setMode(constants.WINDOW_WIDTH, constants.WINDOW_HEIGHT, nil)

require("love/draw")
require("love/update")
require("love/keypress")