local timer = require("keyboard/timer")

function love.keypressed(key, scancode, isrepeat)
    if key == "left" then
        board.movement:moveLeft()
    end
    if key == "right" then
        board.movement:moveRight()
    end
    if key == "down" then
        board.movement:moveDown()
    end
    if key == "up" then
        board.movement:rotateCw()
    end
    if key == "z" then
        board.movement:rotateCcw()
    end
    if key == "space" then
        board.movement:hardDrop()
    end
    if key == "lshift" or key == "rshift" or key == "c" then
        board:holdCurrentTetromino()
    end
end

function love.keyreleased(key, scancode, isrepeat)
    if key == "left" then
        timer.left = 0
    end
    if key == "right" then
        timer.right = 0
    end
    if key == "down" then
        timer.down = 0
    end
end