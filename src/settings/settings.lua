return {
    autoShiftDelay = 12, -- frames
    expiryDelay = 40, -- frames
    leftRightSpeed = 0.4, -- cells per frame
    softDropSpeed = 0.5, -- cells per frame
    gravitySpeed = 0.05, -- cells per frame

    keyBindings = {
        moveLeft = {'left'},
        moveRight = {'right'},
        moveDown = {'down'},
        rotateCw = {'up'},
        rotateCcw = {'z'},
        hardDrop = {'space'},
        hold = {'lshift', 'rshift', 'c'}
    }
}
