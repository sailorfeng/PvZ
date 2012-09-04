-- Animation part

module(..., package.seeall)
require("ResMgr")

function attatch(obj, aniName)
	if obj.aniSp == nil then
		obj.aniSp = CCSprite:createWithSpriteFrame(ResMgr.getAniFaceFrame(aniName))
		obj.sprite:addChild(obj.aniSp, 0, Const.ANI_SP_TAG)
	end

	obj.aniSp:stopAllActions()
	obj.aniSp:runAction(CCRepeatForever:create(CCAnimate:create(ResMgr.getAni(aniName))))
end
