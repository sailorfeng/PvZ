-- ÏòÈÕ¿û
-- by f.f.
module(..., package.seeall)

local PlBase = require("plant.PlBase")
require("ResMgr")
local FSM = require("utils.FSM")
local Coor = require("utils.Coor")
local Shoot = require("action.Shoot")
local Life = require("part.Life")
local Shadow = require("part.Shadow")

SunFlower=class(PlBase.PlBase)
function new(...) return SunFlower.new(...) end

local flowerAni = ResMgr.getAni("SunFlower")
function SunFlower:ctor()
	self.name = "SunFlower."..self.id

	self.sprite = CCLayer:create()
	Shadow.attatch(self, Shadow.NORMAL_SHADOW, -3, -30)

	local sp = CCSprite:createWithSpriteFrame(ResMgr.getAniFaceFrame("SunFlower"))
	sp:runAction(CCRepeatForever:create(CCAnimate:create(flowerAni)))
	self.sprite:addChild(sp)

	Life.attatch(self)

	FSM.set(self, "SFS_STAND")
end

local FSM_INFO = {
	SFS_STAND={
		deal=Shoot.createSun
	},
}

function SunFlower:update()
	FSM.run(self, FSM_INFO)
end
