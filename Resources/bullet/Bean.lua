-- Íã¶¹×Óµ¯
-- by f.f.

module(..., package.seeall)

local BlBase = require("bullet.BlBase")
local ResMgr = require("ResMgr")
local FSM = require("utils.FSM")
local Coor = require("utils.Coor")
local Move = require("action.Move")
local Hurt = require("action.Hurt")
Bean=class(BlBase.BlBase)
function new(...) return Bean.new(...) end

function Bean:ctor()
	self.name = "Bean."..self.id

	self.sprite = CCLayer:node()
	local shd = CCSprite:spriteWithSpriteFrame(ResMgr.getImageFrame("peaShadow"));
	shd:setPosition(0, -50)
	self.sprite:addChild(shd, 0, 1)

	local sp = CCSprite:spriteWithFile(rpath("Bean.png", "Bullet"))
	self.sprite:addChild(sp, 0, 2)

	self.speedX = 4
	self.speedY = 0
	self.power = 30
	FSM.set(self, "BLS_FLY")
end

local FSM_INFO = {
	BLS_FLY={
		function(self)
			if self:myLine() == nil then return nil end

			if self.x >= Const.WIN_WIDTH then return "BLS_END" end
			local zb = self:myLine():getFstZombie(self.x)
			if zb == nil then return nil end
			
			if math.abs(zb.x-self.x) <= Const.BEAN_WIDTH then
				self.hitZb = zb.id
				return "BLS_HIT"
			end
			return nil
		end,
		deal=Move.uniformMove
	},
	BLS_HIT={
		function(self) return "BLS_EXP" end,
		deal=Hurt.bulletHitKeep
	},
	BLS_EXP={
		function(self)
			if self.expTime == nil then self.expTime = 0 end
			self.expTime = self.expTime + 1
			if self.expTime >= 20 then return "BLS_END" end
		end,
		deal=Hurt.bulletExp
	},
	BLS_END={
		deal=function(self) self:myLine():del(self) end
	},
}

function Bean:update()
	FSM.run(self, FSM_INFO)
end
