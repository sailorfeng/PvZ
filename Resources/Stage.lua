-- ¹Ø¿¨
-- by f.f.

--module(..., package.seeall)

require("class")
require("rpath")
local Const = require("Const")
local Coor = require("utils.Coor")
local StLine = require("stage.StLine")

local lineArr = {}
function findObjLine(obj)
	for i,l in ipairs(lineArr) do
		if l:contains(obj) then return l end
	end
	return nil
end

function findObjById(id)
	local obj
	for i,l in ipairs(lineArr) do
		obj = l:findObjById(id)
		if obj ~= nil then return obj end
	end
	return nil
end

local function zombieTest()
	local ZbSimple = require("zombie.ZbSimple")
	local zb = ZbSimple.new()
	zb:initPos(Coor.grid2X(8),0)
	return zb
end

local function plantTest(pos)
	local PeaShooter = require("plant.PeaShooter")
	local pl = PeaShooter.new()
	pl:initPos(Coor.grid2X(pos),-20)
	return pl 
end

local function updateWorld()
	for i, z in ipairs(lineArr) do
		z:update()
	end
end

local sceneGame = CCScene:node()
local function initLines()
	local l

	l = StLine.new()
	l:add(zombieTest())
	print("create zombie done!")
	l:add(plantTest(2))
	print("create plant done!")
	l.layer:setPosition(Const.GRID_LEFT, Coor.line2GlbY(2))

	lineArr[1] = l
	l.id = 1
	for i = #lineArr, 1, -1 do
		sceneGame:addChild(lineArr[i].layer)
	end
end

local function stageTest()
	print("starting...")

	-- create bg
    local bgLayer = CCLayer:node()
	local bg = CCSprite:spriteWithFile(rpath("background.jpg"))
	bg:setPosition(Const.WIN_WIDTH/2+100,Const.WIN_HEIGHT/2-30)
    bgLayer:addChild(bg)
	sceneGame:addChild(bgLayer)
	print("create background done!")

	initLines()

	CCDirector:sharedDirector():runWithScene(sceneGame)
	CCScheduler:sharedScheduler():scheduleScriptFunc(updateWorld, 0, false)
end
stageTest()
