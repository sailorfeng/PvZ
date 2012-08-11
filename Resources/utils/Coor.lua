-- ×ø±êÏµ
-- by f.f.

module(..., package.seeall)

local Const = require("Const")

function pos2Grid(x,y)
	gx = math.floor((x-Const.LINE_X)/Const.GRID_WIDTH) + 1
	gy = math.floor(y/Const.GRID_HEIGHT) + 1
	return gx,gy
end

function grid2Pos(gx,gy)
	x = math.floor(gx * Const.GRID_WIDTH - Const.GRID_WIDTH/2) + Const.LINE_X
	y = math.floor(gy * Const.GRID_HEIGHT - Const.GRID_HEIGHT/2)
	return x,y
end
