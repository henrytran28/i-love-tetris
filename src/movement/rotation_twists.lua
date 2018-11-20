local Point = require("point/point")

-- http://tetris.wikia.com/wiki/List_of_twists
return {
    T = {{
            initialPosition = Point:new(4, 1),
            initialRotationState = 3,
            boundaryPositions = {
                Point:new(3, 0),
                Point:new(3, 1),
                Point:new(4, 0),
                Point:new(6, 0),
                Point:new(6, 2)
            },
            rotation = "ccw",
            finalPosition = Point:new(4, 1),
            finalRotationState = 2,
        },
        {
            initialPosition = Point:new(3, 2),
            initialRotationState = 1,
            boundaryPositions = {
                Point:new(3, 0),
                Point:new(3, 1),
                Point:new(3, 2),
                Point:new(4, 0),
                Point:new(6, 0),
                Point:new(6, 2),
                Point:new(7, 0),
                Point:new(7, 1),
                Point:new(7, 2)
            },
            rotation = "cw",
            finalPosition = Point:new(4, 1),
            finalRotationState = 2,
        },
        {
            initialPosition = Point:new(6, 1),
            initialRotationState = 0,
            boundaryPositions = {
                Point:new(5, 0),
                Point:new(5, 1),
                Point:new(5, 2),
                Point:new(7, 0),
                Point:new(8, 0),
            },
            rotation = "cw",
            finalPosition = Point:new(5, 1),
            finalRotationState = 1,
        },
        {
            initialPosition = Point:new(0, 1),
            initialRotationState = 0,
            boundaryPositions = {
                Point:new(1, 0),
                Point:new(2, 0),
                Point:new(3, 0),
                Point:new(3, 1)
            },
            rotation = "cw",
            finalPosition = Point:new(-1, 1),
            finalRotationState = 1
        },
        {
            initialPosition = Point:new(2, 3),
            initialRotationState = 0,
            boundaryPositions = {
                Point:new(2, 0),
                Point:new(2, 1),
                Point:new(2, 2),
                Point:new(3, 0),
                Point:new(3, 2),
                Point:new(4, 4),
                Point:new(5, 0),
                Point:new(5, 1),
                Point:new(5, 2),
                Point:new(5, 3),
                Point:new(5, 4)
            },
            rotation = "ccw",
            finalPosition = Point:new(3, 1),
            finalRotationState = 3
        },
        {
            initialPosition = Point:new(4, 1),
            initialRotationState = 0,
            boundaryPositions = {
                Point:new(3, 0),
                Point:new(3, 1),
                Point:new(3, 2),
                Point:new(3, 3),
                Point:new(4, 3),
                Point:new(5, 0),
                Point:new(6, 0)
            },
            rotation = "cw",
            finalPosition = Point:new(3, 1),
            finalRotationState = 1
        },
    },
    I = {{
            initialPosition = Point:new(3, 2),
            initialRotationState = 3,
            boundaryPositions = {
                Point:new(3, 0),
                Point:new(3, 1),
                Point:new(3, 2),
                Point:new(5, 1),
                Point:new(6, 1),
                Point:new(6, 2),
                Point:new(7, 1),
                Point:new(8, 1),
            },
            rotation = "cw",
            finalPosition = Point:new(4, 0),
            finalRotationState = 0
        },
        {
            initialPosition = Point:new(3, 2),
            initialRotationState = 1,
            boundaryPositions = {
                Point:new(0, 0),
                Point:new(0, 1),
                Point:new(1, 1),
                Point:new(2, 1),
                Point:new(2, 2),
                Point:new(3, 1),
                Point:new(3, 2),
                Point:new(4, 1),
                Point:new(6, 0),
                Point:new(6, 1),
                Point:new(6, 2),
                Point:new(7, 1),
            },
            rotation = "ccw",
            finalPosition = Point:new(5, 3),
            finalRotationState = 0
        },
        {
            initialPosition = Point:new(3, 2),
            initialRotationState = 1,
            boundaryPositions = {
                Point:new(0, 0),
                Point:new(0, 1),
                Point:new(1, 1),
                Point:new(2, 1),
                Point:new(2, 2),
                Point:new(3, 1),
                Point:new(3, 2),
                Point:new(4, 1),
                Point:new(6, 0),
                Point:new(6, 1),
                Point:new(6, 2),
                Point:new(7, 1),
                Point:new(8, 3),
            },
            rotation = "ccw",
            finalPosition = Point:new(2, 0),
            finalRotationState = 0
        },
        {
            initialPosition = Point:new(4, 2),
            initialRotationState = 3,
            boundaryPositions = {
                Point:new(0, 0),
                Point:new(0, 1),
                Point:new(1, 1),
                Point:new(2, 1),
                Point:new(2, 2),
                Point:new(3, 1),
                Point:new(3, 2),
                Point:new(4, 1),
                Point:new(6, 0),
                Point:new(6, 1),
                Point:new(6, 2),
                Point:new(7, 1),
                Point:new(8, 3),
            },
            rotation = "ccw",
            finalPosition = Point:new(2, 1),
            finalRotationState = 2
        },
    },
    J = {{
            initialPosition = Point:new(2, 1),
            initialRotationState = 1,
            boundaryPositions = {
                Point:new(2, 0),
                Point:new(2, 1),
                Point:new(4, 1),
                Point:new(5, 1),
                Point:new(6, 0),
                Point:new(6, 1)
            },
            rotation = "ccw",
            finalPosition = Point:new(3, 0),
            finalRotationState = 0
        },
        {
            initialPosition = Point:new(6, 1),
            initialRotationState = 3,
            boundaryPositions = {
                Point:new(4, 0),
                Point:new(4, 1),
                Point:new(4, 2),
                Point:new(5, 2),
                Point:new(6, 1),
                Point:new(6, 2)
            },
            rotation = "cw",
            finalPosition = Point:new(5, 0),
            finalRotationState = 0
        },
        {
            initialPosition = Point:new(2, 2),
            initialRotationState = 1,
            boundaryPositions = {
                Point:new(3, 0),
                Point:new(4, 0),
                Point:new(4, 2),
                Point:new(5, 2),
                Point:new(6, 0),
                Point:new(6, 1),
                Point:new(6, 2)
            },
            rotation = "cw",
            finalPosition = Point:new(3, 1),
            finalRotationState = 2
        },
        {
            initialPosition = Point:new(2, 1),
            initialRotationState = 1,
            boundaryPositions = {
                Point:new(4, 0),
                Point:new(5, 2),
                Point:new(6, 0),
                Point:new(6, 1),
                Point:new(6, 2)
            },
            rotation = "cw",
            finalPosition = Point:new(3, 1),
            finalRotationState = 2
        },
        {
            initialPosition = Point:new(2, 2),
            initialRotationState = 1,
            boundaryPositions = {
                Point:new(2, 0),
                Point:new(2, 1),
                Point:new(2, 2),
                Point:new(3, 0),
                Point:new(4, 0),
                Point:new(5, 2),
                Point:new(6, 0),
                Point:new(6, 1),
                Point:new(6, 2)
            },
            rotation = "cw",
            finalPosition = Point:new(3, 1),
            finalRotationState = 2
        },
        {
            initialPosition = Point:new(4, 2),
            initialRotationState = 3,
            boundaryPositions = {
                Point:new(2, 0),
                Point:new(2, 1),
                Point:new(2, 2),
                Point:new(3, 0),
                Point:new(3, 2),
                Point:new(4, 0),
                Point:new(6, 0),
                Point:new(6, 1)
            },
            rotation = "ccw",
            finalPosition = Point:new(3, 1),
            finalRotationState = 2
        },
        {
            initialPosition = Point:new(4, 2),
            initialRotationState = 3,
            boundaryPositions = {
                Point:new(2, 0),
                Point:new(2, 1),
                Point:new(2, 2),
                Point:new(3, 0),
                Point:new(3, 2),
                Point:new(4, 0),
                Point:new(4, 2),
                Point:new(6, 2)
            },
            rotation = "ccw",
            finalPosition = Point:new(3, 1),
            finalRotationState = 2
        },
    },
    L = {{
            initialPosition = Point:new(3, 1),
            initialRotationState = 1,
            boundaryPositions = {
                Point:new(2, 0),
                Point:new(2, 1),
                Point:new(5, 2),
                Point:new(6, 0),
                Point:new(6, 1),
                Point:new(6, 2)
            },
            rotation = "cw",
            finalPosition = Point:new(3, 1),
            finalRotationState = 2
        },
        {
            initialPosition = Point:new(4, 1),
            initialRotationState = 3,
            boundaryPositions = {
                Point:new(2, 0),
                Point:new(2, 1),
                Point:new(3, 1),
                Point:new(4, 1),
                Point:new(6, 0),
                Point:new(6, 1)
            },
            rotation = "cw",
            finalPosition = Point:new(3, 0),
            finalRotationState = 0
        },
        {
            initialPosition = Point:new(1, 1),
            initialRotationState = 1,
            boundaryPositions = {
                Point:new(3, 1),
                Point:new(3, 2),
                Point:new(4, 2),
                Point:new(5, 0),
                Point:new(5, 1),
                Point:new(5, 2)
            },
            rotation = "ccw",
            finalPosition = Point:new(2, 0),
            finalRotationState = 0
        },
        {
            initialPosition = Point:new(5, 2),
            initialRotationState = 3,
            boundaryPositions = {
                Point:new(3, 0),
                Point:new(3, 1),
                Point:new(3, 2),
                Point:new(4, 2),
                Point:new(5, 0),
                Point:new(5, 2),
                Point:new(6, 0),
                Point:new(7, 0)
            },
            rotation = "ccw",
            finalPosition = Point:new(4, 1),
            finalRotationState = 2
        },
        {
            initialPosition = Point:new(5, 1),
            initialRotationState = 3,
            boundaryPositions = {
                Point:new(3, 0),
                Point:new(3, 1),
                Point:new(3, 2),
                Point:new(4, 2),
                Point:new(5, 0)
            },
            rotation = "ccw",
            finalPosition = Point:new(4, 1),
            finalRotationState = 2
        },
        {
            initialPosition = Point:new(4, 2),
            initialRotationState = 3,
            boundaryPositions = {
                Point:new(2, 0),
                Point:new(2, 1),
                Point:new(2, 2),
                Point:new(3, 2),
                Point:new(4, 0),
                Point:new(5, 0),
                Point:new(6, 0),
                Point:new(6, 1),
                Point:new(6, 2)
            },
            rotation = "ccw",
            finalPosition = Point:new(3, 1),
            finalRotationState = 2
        },
        {
            initialPosition = Point:new(2, 2),
            initialRotationState = 1,
            boundaryPositions = {
                Point:new(2, 0),
                Point:new(2, 1),
                Point:new(4, 0),
                Point:new(5, 0),
                Point:new(5, 2),
                Point:new(6, 0),
                Point:new(6, 1),
                Point:new(6, 2)
            },
            rotation = "cw",
            finalPosition = Point:new(3, 1),
            finalRotationState = 2
        },
        {
            initialPosition = Point:new(4, 2),
            initialRotationState = 1,
            boundaryPositions = {
                Point:new(4, 0),
                Point:new(6, 0),
                Point:new(6, 2),
                Point:new(7, 0),
                Point:new(7, 2),
                Point:new(8, 0),
                Point:new(8, 1),
                Point:new(8, 2)
            },
            rotation = "cw",
            finalPosition = Point:new(5, 1),
            finalRotationState = 2
        },
    },
    S = {{
            initialPosition = Point:new(3, 1),
            initialRotationState = 3,
            boundaryPositions = {
                Point:new(2, 0),
                Point:new(2, 1),
                Point:new(5, 0),
                Point:new(5, 2),
                Point:new(6, 0),
                Point:new(6, 1),
                Point:new(6, 2)
            },
            rotation = "ccw",
            finalPosition = Point:new(3, 1),
            finalRotationState = 2
        },
        {
            initialPosition = Point:new(2, 2),
            initialRotationState = 1,
            boundaryPositions = {
                Point:new(2, 0),
                Point:new(2, 1),
                Point:new(3, 1),
                Point:new(5, 0),
                Point:new(6, 0),
                Point:new(6, 1)
            },
            rotation = "cw",
            finalPosition = Point:new(3, 1),
            finalRotationState = 2
        },
        {
            initialPosition = Point:new(4, 3),
            initialRotationState = 0,
            boundaryPositions = {
                Point:new(3, 0),
                Point:new(3, 1),
                Point:new(3, 2),
                Point:new(3, 3),
                Point:new(3, 4),
                Point:new(4, 0),
                Point:new(4, 4),
                Point:new(5, 2),
                Point:new(6, 0),
                Point:new(6, 1),
                Point:new(6, 2)
            },
            rotation = "cw",
            finalPosition = Point:new(3, 1),
            finalRotationState = 1
        },
    },
    Z = {{
            initialPosition = Point:new(4, 1),
            initialRotationState = 1,
            boundaryPositions = {
                Point:new(3, 0),
                Point:new(3, 1),
                Point:new(3, 2),
                Point:new(4, 0),
                Point:new(4, 2),
                Point:new(7, 0),
                Point:new(7, 1)
            },
            rotation = "cw",
            finalPosition = Point:new(4, 1),
            finalRotationState = 2
        },
        {
            initialPosition = Point:new(3, 3),
            initialRotationState = 0,
            boundaryPositions = {
                Point:new(3, 0),
                Point:new(3, 1),
                Point:new(3, 2),
                Point:new(4, 2),
                Point:new(5, 0),
                Point:new(5, 4),
                Point:new(6, 0),
                Point:new(6, 1),
                Point:new(6, 2),
                Point:new(6, 3),
                Point:new(6, 4)
            },
            rotation = "ccw",
            finalPosition = Point:new(4, 1),
            finalRotationState = 3
        },
    },
}
