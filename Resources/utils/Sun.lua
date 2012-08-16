-- Ì«Ñô
-- by f.f.

module(..., package.seeall)

local PzObj = require("PzObj")
local UI = require("stage.UI")
local FSM = require("utils.FSM")
local Move = require("action.Move")
local Coor = require("utils.Coor")
Sun=class(PzObj.PzObj)
function new(...) return Sun.new(...) end

local sunAni = ResMgr.getAni("Sun")

function Sun:ctor()
	self.type = PzObj.SUN_TYPE
	self.x = 0
	self.y = 0
	self.score = 25

	self.sprite = CCSprite:spriteWithSpriteFrame(ResMgr.getAniFaceFrame("Sun"))
	self.sprite:runAction(CCRepeatForever:actionWithAction(CCAnimate:actionWithAnimation(sunAni)))
	self.sprite:setOpacity(230)
end

function Sun:initPath(x,y,toY)
	self.x = x
	self.y = y
	self.sprite:setPosition(math.floor(self.x),math.floor(self.y))
	self.toX = x + math.random(-50, 50)
	self.toY = toY
	self.speedX = 0
	if self.toX < x then self.speedX = -1 elseif self.toX > x then self.speedX = 1 end
	self.speedY = -1
	FSM.set(self, "SUNS_DROP")
--	print("initPath", x,y,toY)
end

local PICK_POS = CCPointMake(30, Const.WIN_HEIGHT-30)
local FSM_INFO = {
	SUNS_DROP={
		function(self)
			if self.dropTime == nil then self.dropTime = 0 end
			self.dropTime = self.dropTime + 1
			if self.dropTime > 1000 then return "SUNS_END" end
			return nil
		end,
		deal= function(self)
			if self.x ~= self.toX then self.x = self.x + self.speedX end
			if self.y > self.toY then self.y = self.y + self.speedY end
			self.sprite:setPosition(math.floor(self.x),math.floor(self.y))
		end
	},
	SUNS_PICK={
		function(self)
			if Coor.distance(CCPointMake(self.x, self.y), CCPointMake(self.toX, self.toY)) < 50 then return "SUNS_END" end
			return nil
		end,
		deal=Move.moveToPos
	},
	SUNS_END={
		deal=function(self)
			addScore(self.score)
			UI.delTouchObj(self)
		end
	},
}

function Sun:update()
	FSM.run(self, FSM_INFO)
--	print("update:", self.fsm.currState)
end

function Sun:onTouch(eventType, x, y)	
	-- TODO: add score
	local pp = self.sprite:getParent():convertToNodeSpace(PICK_POS)
	self.toX = pp.x -- self.x + pp.x
	self.toY = pp.y -- self.y + pp.y
	self.speed = 10
	FSM.set(self, "SUNS_PICK")
--	print("SUNS_On_touch")
end
