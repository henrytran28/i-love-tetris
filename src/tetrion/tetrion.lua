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
    love.graphics.rectangle("fill", 510, 0, 210, 600)

    -- Render the held piece and next piece background
    self:renderHeldPieceBackground()
    self.renderNextPieceBackground()

    -- Render the held piece and the next piece
    self:renderHeldPiece()
    self:renderNextPiece()
end

function Tetrion:renderHeldPieceBackground()
    love.graphics.setColor(colors.JET)
    love.graphics.rectangle("fill", 30, 30, 150, 150)
    love.graphics.setColor(colors.ASH)
    love.graphics.rectangle("line", 30, 30, 150, 150)
end

function Tetrion:renderNextPieceBackground()
    love.graphics.setColor(colors.JET)
    love.graphics.rectangle("fill", 540, 30, 150, 150)
    love.graphics.setColor(colors.ASH)
    love.graphics.rectangle("line", 540, 30, 150, 150)
end

function Tetrion:renderHeldPiece()
    if self.board.heldTetromino then
        heldPieceID = self.board.heldTetromino.id
        heldPiece = Tetromino:new(heldPieceID,
            properties.HOLD[heldPieceID], properties.COLORS[heldPieceID])
        heldPiece:render()
    end
end

function Tetrion:renderNextPiece()
    if self.board.nextTetromino then
        nextPieceID = self.board.nextTetromino.id
        nextPiece = Tetromino:new(nextPieceID,
            properties.NEXT[nextPieceID], properties.COLORS[nextPieceID])
        nextPiece:render()
    end
end

return Tetrion
