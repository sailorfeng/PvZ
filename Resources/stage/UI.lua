-- UI部分
-- 目前只有放下植物等等有限功能
-- by f.f.

module(..., package.seeall)
local Coor = require("utils.Coor")
local ResMgr = require("ResMgr")

local touchLayer = CCLayer:node()
local dropSprite = nil

local function onTouch(eventType, x, y)
	local fx,fy = Coor.glbPosFix(x,y)
	fy = fy-20
	if eventType == CCTOUCHBEGAN then
		dropSprite = CCSprite:spriteWithSpriteFrame(ResMgr.getAniFaceFrame("PeaShooterStand"))
		dropSprite:setPosition(fx,fy)
		dropSprite:setOpacity(100)
		touchLayer:addChild(dropSprite)
		return true
	end

	if eventType == CCTOUCHMOVED then
		dropSprite:setPosition(fx,fy)
	elseif eventType == CCTOUCHENDED then
		local l = Coor.glbY2Line(fy)
		local g = Coor.glbX2Grid(fx)
		addPlant(0, l, g)
		touchLayer:removeChild(dropSprite, true)
	end
end

function initUI(scene)
	touchLayer:registerScriptTouchHandler(onTouch)
	touchLayer:setIsTouchEnabled(true)
	scene:addChild(touchLayer)
end

