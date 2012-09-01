-- life part, give life to PzObj

module(..., package.seeall)
require("Const")

local LIFE_BAR_X = -15
local LIFE_BAR_Y = 65

function attatch(obj)
	local hpEmpty = CCSprite:createWithSpriteFrame(ResMgr.getImageFrame("hpEmpty"))
	hpEmpty:setPosition(LIFE_BAR_X, LIFE_BAR_Y)
	obj.sprite:addChild(hpEmpty)

	local hpBar = CCProgressTimer:create(CCSprite:createWithSpriteFrame(ResMgr.getImageFrame("hpFull")))

	hpBar:setType(kCCProgressTimerTypeBar)
	hpBar:setMidpoint(CCPointMake(0, 0.5))
	hpBar:setBarChangeRate(CCPointMake(1, 0))
	hpBar:setPercentage(100)
	hpBar:setPosition(LIFE_BAR_X, LIFE_BAR_Y)
	obj.sprite:addChild(hpBar, 2, Const.LIFE_BAR_TAG)

	obj.hpMax = 100
	obj.hp = obj.hpMax
end

function hurt(obj, drop)
	if obj.hp == nil then return end

	obj.hp = obj.hp - drop
--	print("obj:"..obj.id.." hurt:"..drop.." hp:"..obj.hp)

	local hpBar = obj.sprite:getChildByTag(Const.LIFE_BAR_TAG)
	if hpBar ~= nil then hpBar:setPercentage(obj.hp / obj.hpMax * 100) end
	if obj.hp <= 0 then obj:die() end
end
