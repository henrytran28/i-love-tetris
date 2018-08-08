local Board = require("board")

unit = 40
width = 10 * unit
height = 22 * unit
love.window.setMode(width, height, nil)

function love.init()
    Board:init()
end

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

-- function love.load()
--     love.keyboard.setKeyRepeat(false)
--     x = 50
--     y = 100
-- end

-- function love.draw()
--     love.graphics.circle("fill", x, y, 100)
-- end

-- function love.keypressed(key, scancode, isrepeat)
--     if key == "up" then
--         y = (y - 10) % love.graphics.getHeight()
--     end
-- end


-- function love.update(dt)
--     if love.keyboard.isDown("right") then
--          x = (x + 10) % love.graphics.getWidth()
--     end
--     if love.keyboard.isDown("left") then
--          x = (x - 10) % love.graphics.getWidth()
--     end
--     if love.keyboard.isDown("down") then
--         y = (y + 10) % love.graphics.getHeight()
--     end
-- end