local Board = require("board")

unit = 40
width = 10 * unit
height = 22 * unit
love.window.setMode(width, height, nil)

function love.draw()
    Board:render()
end

function love.keypressed(key, scancode, isrepeat)
    if key == "up" then
        Board.movement:rotateCw()
    end
    if key == "z" then
        Board.movement:rotateCcw()
    end
    if key == "space" then
        Board.movement:hardDrop()
    end
    if key == "lshift" then
        Board:holdCurrentTetromino()
    end
end

function love.update(dt)
    if love.keyboard.isDown("left") then
        Board.movement:moveLeft()
    end
    if love.keyboard.isDown("right") then
        Board.movement:moveRight()
    end
    if love.keyboard.isDown("down") then
        Board.movement:moveDown()
    end
end
