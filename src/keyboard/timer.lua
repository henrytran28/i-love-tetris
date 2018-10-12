local Timer = {}

Timer.left = 0
Timer.right = 0
Timer.down = 0

function Timer.calculateTime(timeAtMin, timeAtMax, speedPercent)
    return ((timeAtMax - timeAtMin) / 100) * speedPercent + timeAtMin
end

return Timer
