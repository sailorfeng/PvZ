-- Õ„∂π…‰ ÷
-- by f.f.

module(..., package.seeall)

local PlBase = require("plant.PlBase")
local ResMgr = require("ResMgr")
local FSM = require("utils.FSM")
local Coor = require("utils.Coor")
local Shoot = require("action.Shoot")
local Life = require("part.Life")
local Shadow = require("part.Shadow")

local standAniName = "PeaShooterStand"
local standAni = ResMgr.getAni(standAniName)
local fireAniName = "PeaShooterFire"
local fireAni = ResMgr.getAni(fireAniName)

PeaShooter=class(PlBase.PlBase)
function new(...) return PeaShooter.new(...) end

function PeaShooter:ctor()
	self.name = "PeaShooter."..self.id

	self.sprite = CCLayer:create()
	Shadow.attatch(self, Shadow.NORMAL_SHADOW, -3, -30)

	local sp = CCSprite:createWithSpriteFrame(ResMgr.getAniFaceFrame(standAniName))
	sp:runAction(CCRepeatForever:create(CCAnimate:create(standAni)))
	self.sprite:addChild(sp)

	Life.attatch(self)

	FSM.set(self, "PSS_STAND")
end

local FSM_INFO = {
	PSS_STAND={
		function(self)
			if self:myLine() == nil then return nil end
			local zb = self:myLine():getFstZombie(self.x)
			if zb ~= nil then return "PSS_SHOOT" end
			return nil
		end,
	},
	PSS_SHOOT={
		function(self)
			if self:myLine() == nil then return "PSS_STAND" end
			local zb = self:myLine():getFstZombie(self.x)
			if zb == nil then return "PSS_STAND" end
			return nil
		end,
		deal=Shoot.oneBean
	},
}

function PeaShooter:update()
	FSM.run(self, FSM_INFO)
end
