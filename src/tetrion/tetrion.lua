local board = require("board/board")
local utils = require("utils/utils")
local inspect = require("inspect")
local colors = require("colors/colors")
local constants = require("constants")

local Tetrion = {}

function Tetrion:new(board, width, height)
    local tetrion = {
        board = board,
    }
    self.__index = self
    setmetatable(tetrion, self)
    return tetrion
end

function Tetrion:render()
    love.graphics.setColor(colors.CHARCOAL)
    love.graphics.rectangle("fill", 0, 0, 210, 600)
    -- Render the held piece background
    self:renderHeldPiecePreview()
    -- Render the held piece
    self:renderHeldPiece()
end

function Tetrion:renderHeldPiecePreview()
    love.graphics.setColor(colors.JET)
    love.graphics.rectangle("fill", 30, 30, 150, 150)
end

function Tetrion:renderHeldPiece()
end

return Tetrion
