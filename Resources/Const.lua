-- ������
-- by f.f.

module(..., package.seeall)

local winSize = CCDirector:sharedDirector():getWinSize()
WIN_WIDTH=winSize.width
WIN_HEIGHT=winSize.height

GRID_WIDTH=81
GRID_HEIGHT=98

GRID_MAX = 9
LINE_MAX = 5

-- ����������·�������
GRID_TOP = 40
-- �����������ߵ�����
GRID_LEFT = 130

FIELD=CCRectMake(GRID_TOP, GRID_LEFT, GRID_WIDTH*GRID_MAX, GRID_HEIGHT*LINE_MAX)

BEAN_WIDTH=28

MAX_INT=0x7FFFFFFF
MIN_INT=0x80000000

-- ����tag
LIFE_BAR_TAG = 1000
ANI_SP_TAG = 1001
SHADOW_SP_TAG = 1002
