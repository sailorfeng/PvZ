-- Õ„∂π…‰ ÷
-- by f.f.

module(..., package.seeall)

local PlBase = require("plant.PlBase")
local ResMgr = require("ResMgr")
local FSM = require("utils.FSM")
local Coor = require("utils.Coor")
PeaShooter=class(PlBase.PlBase)
function new(...) return PeaShooter.new(...) end

local standAniName = "PeaShooterStand"
local standAni = ResMgr.getAni(standAniName)
local fireAniName = "PeaShooterFire"
local fireAni = ResMgr.getAni(fireAniName)

function PeaShooter:ctor()
	self.name = "PeaShooter."..self.id
	self.sprite = CCSprite:spriteWithSpriteFrame(ResMgr.getAniFaceFrame(standAniName))
	self.sprite:runAction(CCRepeatForever:actionWithAction(CCAnimate:actionWithAnimation(standAni)))
	self.hpMax = 100
	self.hp = self.hpMax
	FSM.set(self, "PSS_STAND")
end

local FSM_INFO = {
	PSS_STAND={
		function(self)
--			local gx, gy = Coor.pos2Grid(self.x, self.y)
--			if l == nil or l.getPlantByIndex(gx) == nil then return "ZSS_EAT" end
		end,
		deal=stand
	},
}

function PeaShooter:stand()
--	print("PeaShooter stand")
end

function PeaShooter:shoot()
	print("PeaShooter shoot")
end

function PeaShooter:update()
	FSM.run(self, FSM_INFO)
end
