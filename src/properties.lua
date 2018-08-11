local Point = require("point")
local colors = require("colors")
local wallKickTable = require("wall_kick_table")

local properties = {
    LAYOUTS = {
        O = { Point:new(0, 0), Point:new(1, 0), Point:new(1, 1), Point:new(0, 1) },
        I = { Point:new(0, 0), Point:new(1, 0), Point:new(2, 0), Point:new(3, 0) },
        J = { Point:new(0, 0), Point:new(1, 0), Point:new(2, 0), Point:new(0, 1) },
        L = { Point:new(0, 0), Point:new(1, 0), Point:new(2, 0), Point:new(2, 1) },
        S = { Point:new(0, 0), Point:new(1, 0), Point:new(1, 1), Point:new(2, 1) },
        Z = { Point:new(1, 0), Point:new(1, 1), Point:new(0, 1), Point:new(2, 0) },
        T = { Point:new(0, 0), Point:new(1, 0), Point:new(1, 1), Point:new(2, 0) }
    },
    SPAWN = {
        O = Point:new(4, 20),
        I = Point:new(3, 20),
        J = Point:new(3, 20),
        L = Point:new(3, 20),
        S = Point:new(3, 20),
        Z = Point:new(3, 20),
        T = Point:new(3, 20)
    },
    ROTATION_POINTS = {
        O = Point:new(1.0, 1.0),
        I = Point:new(2.0, 0.0),
        J = Point:new(1.5, 0.5),
        L = Point:new(1.5, 0.5),
        S = Point:new(1.5, 0.5),
        Z = Point:new(1.5, 0.5),
        T = Point:new(1.5, 0.5)
    },
    WALL_KICKS_CW = {
        J = wallKickTable.CW.JLSTZ,
        L = wallKickTable.CW.JLSTZ,
        S = wallKickTable.CW.JLSTZ,
        T = wallKickTable.CW.JLSTZ,
        Z = wallKickTable.CW.JLSTZ,
        I = wallKickTable.CW.I,
    },
    WALL_KICKS_CCW = {
        J = wallKickTable.CCW.JLSTZ,
        L = wallKickTable.CCW.JLSTZ,
        S = wallKickTable.CCW.JLSTZ,
        T = wallKickTable.CCW.JLSTZ,
        Z = wallKickTable.CCW.JLSTZ,
        I = wallKickTable.CCW.I,
    },
    COLORS = {
        O = colors.YELLOW,
        I = colors.TEAL,
        J = colors.BLUE,
        L = colors.ORANGE,
        S = colors.GREEN,
        Z = colors.RED,
        T = colors.PURPLE
    }
}

return properties