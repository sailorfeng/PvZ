-- 关卡
-- by f.f.

--module(..., package.seeall)

require("class")
require("rpath")
local Const = require("Const")
local Coor = require("utils.Coor")
local StLine = require("stage.StLine")
local UI = require("stage.UI")
local Sun = require("utils.Sun")

local ZbSimple = require("zombie.ZbSimple")
local PeaShooter = require("plant.PeaShooter")
local SunFlower = require("plant.SunFlower")

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

local score = 0
local scoreLabel = nil
function addScore(s)
	score = score + s
	scoreLabel:setString(score)
end

local function zombieTest()
	local zb = ZbSimple.new()
	zb:initPos(Coor.grid2X(math.random(6,9)),0)
	return zb
end

local function plantTest(pos)
	local pl = SunFlower.new()
	pl:initPos(Coor.grid2X(pos),-20)
	return pl 
end

function addPlant(what, line, pos)
--	print("addPlant", line, pos)
	if lineArr[line]:getPlantByGrid(pos) ~= nil then return end
	local pl = plantTest(pos)
	lineArr[line]:add(pl)
end

local zbCount = 0
CurrFrame = 0
local function updateWorld()
	CurrFrame = CurrFrame + 1
	for i, z in ipairs(lineArr) do
		z:update()
	end

	UI.update()

	-- 随机出僵尸
	if zbCount < 5 and math.random() < 0.1 then
		zbCount = zbCount + 1
		lineArr[math.random(#lineArr)]:add(zombieTest())
	end

	-- 随机出太阳
	if CurrFrame % 1000 == 0 then
		local sun = Sun.new()
		sun:initPath(math.random(CCRect:CCRectGetMinX(Const.FIELD), CCRect:CCRectGetMaxX(Const.FIELD)), Const.WIN_HEIGHT + 100, Coor.line2GlbY(math.random(Const.LINE_MAX)) - 30)
		UI.addTouchObj(sun)
	end
end

local sceneGame = CCScene:node()
local function initLines()
	local l

	for i = 1, 5 do
		l = StLine.new()
		l.layer:setPosition(Const.GRID_LEFT, Coor.line2GlbY(i))
		l.id = i
		lineArr[i] = l
--		l:add(plantTest(math.random(3)))
	end

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

	-- 初始化每一行
	initLines()

	-- 初始化UI
	UI.initUI(sceneGame)

	if scoreLabel == nil then
		local sun = CCSprite:spriteWithSpriteFrame(ResMgr.getAniFaceFrame("Sun"))
		sun:setPosition(30, Const.WIN_HEIGHT-30)
		sceneGame:addChild(sun)

		scoreLabel = CCLabelTTF:labelWithString("0", "Arial", 28)
		scoreLabel:setPosition(80, Const.WIN_HEIGHT-25)
		sceneGame:addChild(scoreLabel)
	end
	addScore(0)

	CCDirector:sharedDirector():runWithScene(sceneGame)
	CCScheduler:sharedScheduler():scheduleScriptFunc(updateWorld, 0, false)
	print("Game initialize done!")
end

math.randomseed(os.time())
stageTest()
