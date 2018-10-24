return {
    leftRightSpeedPercent = 50,
    softDropSpeedPercent = 50,
    delayedAutoShiftPercent = 50,
    gravitySpeedPercent = 50,

    keyBindings = {
        ['self.board.movement:moveLeft'] = {'left'},
        ['self.board.movement:moveRight'] = {'right'},
        ['self.board.movement:moveDown'] = {'down'},
        ['self.board.movement:rotateCw'] = {'up'},
        ['self.board.movement:rotateCcw'] = {'z'},
        ['self.board.movement:hardDrop'] = {'space'},
        ['self.board:holdCurrentTetromino'] = {'lshift', 'rshift', 'c'}
    }
}
