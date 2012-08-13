-- ����ϵ
-- by f.f.

module(..., package.seeall)

local Const = require("Const")

function x2Grid(x)
	return math.floor(x/Const.GRID_WIDTH) + 1
end

function grid2X(idx)
	return math.floor(idx * Const.GRID_WIDTH - Const.GRID_WIDTH/2)
end

function glbX2Grid(x)
	return x2Grid(x - Const.GRID_LEFT)
end

function grid2GlbX(idx)
	return grid2X(idx) + Const.GRID_LEFT
end

function glbY2Line(y)
	return math.floor((y - Const.GRID_TOP)/Const.GRID_HEIGHT) + 1
end

function line2GlbY(idx)
	return math.floor(idx * Const.GRID_HEIGHT - Const.GRID_HEIGHT/2) + Const.GRID_TOP
end
