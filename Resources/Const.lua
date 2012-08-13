-- 常量表
-- by f.f.

module(..., package.seeall)

local winSize = CCDirector:sharedDirector():getWinSize()
WIN_WIDTH=winSize.width
WIN_HEIGHT=winSize.height

GRID_WIDTH=81
GRID_HEIGHT=98

-- 网格距离最下方的像素
GRID_TOP = 40
-- 网格距离最左边的像素
GRID_LEFT = 130

BEAN_WIDTH=28

MAX_INT=0x7FFFFFFF
MIN_INT=0x80000000
