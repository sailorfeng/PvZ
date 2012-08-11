-- 关卡中的一条横线
-- by f.f.

module(..., package.seeall)

StLine=class()
function new(...) return StLine.new(...) end

local PzObj = require("PzObj")
local Const = require("Const")
local Coor = require("utils.Coor")

function StLine:ctor()
	self.objList = {} 
	self.objList[PzObj.ZOMBIE_TYPE]={}
	self.objList[PzObj.PLANT_TYPE]={}
	self.objList[PzObj.BULLET_TYPE]={}
    self.layer = CCLayer:node()
end

local zOrderVal = { }
print(PzObj.BULLET_TYPE)
zOrderVal[PzObj.BULLET_TYPE]=2
zOrderVal[PzObj.ZOMBIE_TYPE]=1
zOrderVal[PzObj.PLANT_TYPE]=0

function StLine:add(obj)
	if obj == nil then print(debug.traceback()) end
	self.objList[obj.type][obj.id] = obj
	self.layer:addChild(obj.sprite, zOrderVal[obj.type], obj. id)
end

function StLine:del(obj)
	if type(obj) == type(0) then
		for t, l in pairs(self.objList) do
			l[obj] = nil
		end
	else
		self.objList[obj.type][obj.id] = nil
	end
end

-- 得到从某位置往后第1只zb
function StLine:getFstZombie(posX)
	local minX = Const.WIN_WIDTH
	local zb = nil
	for id, z in pairs(self.objList[PzObj.ZOMBIE_TYPE]) do
		if posX < z.x and z.x < minX then
			minX = z.x
			zb = z
		end
	end
	return zb
end

-- 得到从某位置往前第1棵植物
function StLine:getFstPlant(posX)
	local maxX = 0
	local pl = nil
	for id, z in pairs(self.objList[PzObj.PLANT_TYPE]) do
		if posX > z.x and z.x > maxX then
			maxX = z.x
			pl = z
		end
	end
	return pl
end

function StLine:update()
	for i, o in pairs(self.objList[PzObj.ZOMBIE_TYPE]) do o:update() end
	for i, o in pairs(self.objList[PzObj.PLANT_TYPE]) do o:update() end
	for i, o in pairs(self.objList[PzObj.BULLET_TYPE]) do o:update() end
end

function StLine:getPlantByIndex(idx)
	local gx, gy
	for i, p in pairs(self.objList[PzObj.PLANT_TYPE]) do
		gx,gy = Coor.pos2Grid(p.x, p.y)
		if gx == idx then return p end
	end
	return nil
end

function StLine:contains(obj)
	return self.objList[obj.type][obj.id] ~= nil
end
