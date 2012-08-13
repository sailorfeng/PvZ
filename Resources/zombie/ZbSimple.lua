-- ×î¼òµ¥µÄ½©Ê¬
-- by f.f.

module(..., package.seeall)

local ZbBase = require("zombie.ZbBase")
local ResMgr = require("ResMgr")
local FSM = require("utils.FSM")
local Coor = require("utils.Coor")
local Move = require("action.Move")
local Hurt = require("action.Hurt")
ZbSimple=class(ZbBase.ZbBase)
function new(...) return ZbSimple.new(...) end

local walkAniName = "ZbSimple"
local walkAni = ResMgr.getAni(walkAniName)

function ZbSimple:ctor()
	self.name = "ZbSimple."..self.id
	self.sprite = CCSprite:spriteWithSpriteFrame(ResMgr.getAniFaceFrame(walkAniName))
	self.sprite:runAction(CCRepeatForever:actionWithAction(CCAnimate:actionWithAnimation(walkAni)))
	self.speedX = -0.1
	self.hpMax = 100
	self.hp = self.hpMax
	FSM.set(self, "ZSS_WALK")
end

function ZbSimple:eat()
	print("ZbSimple eat")
end

local FSM_INFO = {
	ZSS_WALK={
		function(self)
			local grid = Coor.x2Grid(self.x)
--			print("x:"..self.x..",y:"..self.y.." gx:"..gx.." gy:"..gy)
--			if self:myLine() ~= nil then print("l:"..self:myLine().id) end
			if self:myLine() ~= nil and self:myLine():getPlantByGrid(gx) ~= nil then return "ZSS_EAT" end
		end,
		deal=Move.uniformMove
	},
	ZSS_EAT={
		deal=Hurt.eat
	},
}

function ZbSimple:update()
	FSM.run(self, FSM_INFO)
--	self:walk()
end
