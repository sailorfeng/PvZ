-- ×î¼òµ¥µÄ½©Ê¬
-- by f.f.

module(..., package.seeall)

local ZbBase = require("zombie.ZbBase")
local ResMgr = require("ResMgr")
ZbSimple=class(ZbBase.ZbBase)

local walkAniName = "ZbSimple"
local walkAni = ResMgr.getAni(walkAniName)

function ZbSimple:ctor()
	self.sprite = CCSprite:spriteWithSpriteFrame(ResMgr.getAniFaceFrame(walkAniName))
	self.sprite:runAction(CCRepeatForever:actionWithAction(CCAnimate:actionWithAnimation(walkAni)))
	self.speedX = -0.1
end

--function ZbSimple:walk()
--	print("ZbSimple walk")
--	ZbSimple.super.walk(self)
--	local x,y = self.sprite:getPosition()
--	self.sprite:setPositionX(x - 1)
--end

function ZbSimple:eat()
	print("ZbSimple eat")
end

function ZbSimple:update()
	self:walk()
end
