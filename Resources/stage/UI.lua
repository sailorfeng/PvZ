-- UI部分
-- 目前只有放下植物等等有限功能
-- by f.f.

module(..., package.seeall)
local Coor = require("utils.Coor")
local ResMgr = require("ResMgr")
local Card = require("utils.Card")

local touchLayer = CCLayer:create()
local dropSprite = nil

local touchObj = {}

local function checkTouchObj(x, y)
	local maxZ = -1
	local touched = nil
	for i, v in pairs(touchObj) do
		local box = v.sprite:boundingBox()
		local pt = touchLayer:convertToNodeSpace(CCPointMake(x,y))
--		print("box", box:getMinX(), box:getMinY(), box:getMaxX(), box:getMaxY(), "pt", pt.x, pt.y)
		if box:containsPoint(pt) then
			if v.z > maxZ then
				maxZ = v.z
				touched = v
			end
		end
	end
	return touched
end

local function canPutPlant(l, g)
	if l < 1 or l > Const.LINE_MAX then return false end
	if g < 1 or g > Const.GRID_MAX then return false end
	if hasPlant(l, g) ~= nil then return false end
	return true
end

local function onTouch(eventType, x, y)
	-- 是否点击了可点击物品
	local touched = checkTouchObj(x,y)
	if touched ~= nil then
		touched:onTouch(eventType, x, y)
		return false
	end

	if Card.isCardOK(getSelectedPlant()) == false then return false end
	local fx,fy = Coor.glbPosFix(x,y)
	fy = fy-20

	local l = Coor.glbY2Line(fy)
	local g = Coor.glbX2Grid(fx)
	local canPut = canPutPlant(l, g)
	if eventType == CCTOUCHBEGAN then
		if canPut == false then return false end

		dropSprite = CCSprite:createWithSpriteFrame(ResMgr.getAniFaceFrame(Card.getCardModel(getSelectedPlant())))
		dropSprite:setPosition(fx,fy)
		dropSprite:setOpacity(100)
		touchLayer:addChild(dropSprite)
		return true
	end

	if eventType == CCTOUCHMOVED then
		if canPut == false then
			dropSprite:setPosition(10000, 10000)
		else
			dropSprite:setPosition(fx,fy)
		end
	elseif eventType == CCTOUCHENDED then
		if canPut and Card.isCardOK(getSelectedPlant()) then
			addPlant(l, g)
		end
		touchLayer:removeChild(dropSprite, true)
	end
end

function initUI(scene)
	touchLayer:registerScriptTouchHandler(onTouch)
	touchLayer:setTouchEnabled(true)
	scene:addChild(touchLayer)
end

function addTouchObj(obj, z)
	touchObj[obj.id] = obj
	if z == nil then z = 0 end
	obj.z = z
	touchLayer:addChild(obj.sprite, z, obj.id)
end

function delTouchObj(obj)
	touchLayer:removeChild(obj.sprite, true)
	touchObj[obj.id] = nil
end

function update()
	for i, z in pairs(touchObj) do
		if z.update ~= nil then z:update() end
	end
end

function reset()
	for i, z in pairs(touchObj) do
		delTouchObj(z)
	end
end
