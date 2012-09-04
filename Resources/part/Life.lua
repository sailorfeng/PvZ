-- life part, give life to PzObj

module(..., package.seeall)
require("Const")

function attatch(obj, posX, posY)
	posX = posX or 0
	posY = posY or 65
	obj.hpEmpty = CCSprite:createWithSpriteFrame(ResMgr.getImageFrame("hpEmpty"))
	obj.hpEmpty:setPosition(posX, posY)
	obj.sprite:addChild(obj.hpEmpty)

	obj.hpBar = CCProgressTimer:create(CCSprite:createWithSpriteFrame(ResMgr.getImageFrame("hpFull")))

	obj.hpBar:setType(kCCProgressTimerTypeBar)
	obj.hpBar:setMidpoint(CCPointMake(0, 0.5))
	obj.hpBar:setBarChangeRate(CCPointMake(1, 0))
	obj.hpBar:setPercentage(100)
	obj.hpBar:setPosition(posX, posY)
	obj.sprite:addChild(obj.hpBar, 2, Const.LIFE_BAR_TAG)

	obj.hpMax = 100
	obj.hp = obj.hpMax
end

function hurt(obj, drop)
	if obj.hp == nil then return end

	obj.hp = obj.hp - drop
--	print("obj:"..obj.id.." hurt:"..drop.." hp:"..obj.hp)

	local hpBar = obj.sprite:getChildByTag(Const.LIFE_BAR_TAG)
	if hpBar ~= nil and hpBar.setPercentage == nil then
		error("what the hell")
	end
	if hpBar ~= nil then hpBar:setPercentage(obj.hp / obj.hpMax * 100) end
	if obj.hp <= 0 then obj:die() end
end
