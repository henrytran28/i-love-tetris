local board = require("board/board")
local Tetromino = require("tetromino/tetromino")
local properties = require("tetromino/properties")
local colors = require("colors/colors")

local Tetrion = {}

function Tetrion:new(board)
    local tetrion = {
        board = board
    }
    self.__index = self
    setmetatable(tetrion, self)
    return tetrion
end

function Tetrion:render()
    -- Render the backdrop
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
    if self.board.heldTetromino then
        heldPieceID = self.board.heldTetromino.id
        heldPiece = Tetromino:new(heldPieceID,
            properties.HOLD[heldPieceID], properties.COLORS[heldPieceID])
        heldPiece:render()
    end
end

return Tetrion
