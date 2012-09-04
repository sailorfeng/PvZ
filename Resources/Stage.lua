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
local Card = require("utils.Card")

local ZbSimple = require("zombie.ZbSimple")

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
function getScore() return score end

selectedPlant = nil
function getSelectedPlant() return selectedPlant end
function setSelectedPlant(n) selectedPlant = n end

local function zombieTest()
	local zb = ZbSimple.new()
	zb:initPos(Coor.grid2X(math.random(6,9)),0)
	return zb
end

function hasPlant(line, pos)
	if line < 1 or line > #lineArr then error(string.format("hasPlant line err:%d", line)) end
	return lineArr[line]:getPlantByGrid(pos)
end

function addPlant(line, pos, force)
--	print("addPlant", line, pos)
	if hasPlant(line, pos) ~= nil then return end

	if force ~= true then
		if score < Card.getCostSun(selectedPlant) then return end
		addScore(-Card.getCostSun(selectedPlant))
	end

	local what = require("plant."..selectedPlant)
	Card.startCD(selectedPlant)

	local pl = what.new()
	pl:initPos(Coor.grid2X(pos),-20)

	lineArr[line]:add(pl)
end

local zbCount = 0
function zbDie() zbCount = zbCount - 1 end
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
		sun:initPath(math.random(Const.FIELD:getMinX(), Const.FIELD:getMaxX()), Const.WIN_HEIGHT + 100, Coor.line2GlbY(math.random(Const.LINE_MAX)) - 30)
		UI.addTouchObj(sun)
	end
end

local sceneGame = CCScene:create()
local function initLines()
	local l

	for i = 1, 5 do
		l = StLine.new()
		l.layer:setPosition(Const.GRID_LEFT, Coor.line2GlbY(i))
		l.id = i
		lineArr[i] = l
	end

	for i = #lineArr, 1, -1 do
		sceneGame:addChild(lineArr[i].layer)
	end
end

local cardNeed = { "PeaShooter", "SunFlower" }
local function initCards()
	for i, n in ipairs(cardNeed) do
		local c = Card.getCard(n)
		c:reset()
		c.sprite:setPosition(100 + i * 110, Const.WIN_HEIGHT - 30)
		UI.addTouchObj(c)
	end
	selectedPlant = cardNeed[1]
end

function resetStage()
	for i = 1, #lineArr do
		lineArr[i]:reset()
	end
	UI.reset()
	-- 初始化卡片
	initCards()

	local exitBtn = { sprite=CCSprite:createWithSpriteFrame(ResMgr.getImageFrame("closeNormal")) }
	exitBtn.id = -10
	exitBtn.sprite:setPosition(Const.WIN_WIDTH - 50, Const.WIN_HEIGHT - 30)
--	exitBtn.onTouch = resetStage
	exitBtn.onTouch = function() CCDirector:sharedDirector():endToLua() end
	UI.addTouchObj(exitBtn)

	addScore(-getScore())
	addScore(100)
	zbCount = 0
end

local function stageTest()
	print("starting...")

	-- create bg
    local bgLayer = CCLayer:create()
	local bg = CCSprite:create(rpath("background.jpg"))
	bg:setPosition(Const.WIN_WIDTH/2+100,Const.WIN_HEIGHT/2-30)
    bgLayer:addChild(bg)
	sceneGame:addChild(bgLayer)

	-- 初始化每一行
	initLines()

	-- 初始化UI
	UI.initUI(sceneGame)

	if scoreLabel == nil then
		local sun = CCSprite:createWithSpriteFrame(ResMgr.getAniFaceFrame("Sun"))
		sun:setPosition(30, Const.WIN_HEIGHT-30)
		sceneGame:addChild(sun)

		scoreLabel = CCLabelTTF:create("0", "Arial", 28)
		scoreLabel:setPosition(80, Const.WIN_HEIGHT-25)
		sceneGame:addChild(scoreLabel)
	end

	resetStage()

	CCDirector:sharedDirector():runWithScene(sceneGame)
	CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(updateWorld, 0, false)

	print("Game initialize done!")
end

math.randomseed(os.time())
stageTest()
