-- ¹Ø¿¨
-- by f.f.

require("class")
require("rpath")

local function zombieTest()
	local ZbSimple = require("zombie.ZbSimple")
	local zb = ZbSimple.ZbSimple.new()
	zb:initPos(450,150)
	return zb
end

local winSize = CCDirector:sharedDirector():getWinSize()

local zbList = {}
local function updateWorld()
	for i, z in pairs(zbList) do
		z:update()
	end
end

local sceneGame = CCScene:node()
local function stageTest()
	print("starting...")

	-- create bg
    local bgLayer = CCLayer:node()
	local bg = CCSprite:spriteWithFile(rpath("background.jpg"))
	bg:setPosition(winSize.width/2,winSize.height/2)
    bgLayer:addChild(bg)
	sceneGame:addChild(bgLayer)
	print("create background done!")

    local zblayer = CCLayer:node()
	local zb = zombieTest()
	zbList[zb.id] = zb
	zblayer:addChild(zb.sprite)
	sceneGame:addChild(zblayer)
	print("create zombie done!")

	CCDirector:sharedDirector():runWithScene(sceneGame)
	CCScheduler:sharedScheduler():scheduleScriptFunc(updateWorld, 0, false)
end

stageTest()
