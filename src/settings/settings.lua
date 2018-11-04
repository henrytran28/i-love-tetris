return {
    autoShiftDelay = 12, -- frames
    leftRightSpeed = 0.4, -- cells per frame
    softDropSpeed = 0.5, -- cells per frame
    gravitySpeed = 0.1, -- cells per frame

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
