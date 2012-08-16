-- ÏòÈÕ¿û
-- by f.f.
module(..., package.seeall)

local PlBase = require("plant.PlBase")
local ResMgr = require("ResMgr")
local FSM = require("utils.FSM")
local Coor = require("utils.Coor")
local Shoot = require("action.Shoot")

SunFlower=class(PlBase.PlBase)
function new(...) return SunFlower.new(...) end

local flowerAni = ResMgr.getAni("SunFlower")
function SunFlower:ctor()
	self.name = "SunFlower."..self.id

	self.sprite = CCLayer:node()
	local shd = CCSprite:spriteWithSpriteFrame(ResMgr.getImageFrame("plantShadow"))
	shd:setPosition(-3, -30)
	self.sprite:addChild(shd)

	local sp = CCSprite:spriteWithSpriteFrame(ResMgr.getAniFaceFrame("SunFlower"))
	sp:runAction(CCRepeatForever:actionWithAction(CCAnimate:actionWithAnimation(flowerAni)))
	self.sprite:addChild(sp)

	local hpEmpty = CCSprite:spriteWithFile(rpath("hpEmpty.png"))
	hpEmpty:setPosition(-15, 65)
	self.sprite:addChild(hpEmpty)

	self.hpBar = CCProgressTimer:progressWithFile(rpath("hpFull.png"))

	self.hpBar:setType(kCCProgressTimerTypeHorizontalBarLR)
	self.hpBar:setPercentage(100)
	self.hpBar:setPosition(-15, 65)
	self.sprite:addChild(self.hpBar, 2, -1)

	self.hpMax = 100
	self.hp = self.hpMax
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
