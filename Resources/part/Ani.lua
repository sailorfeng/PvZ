-- Animation part

module(..., package.seeall)
require("ResMgr")

function attatch(obj, aniName)
	local sp = obj.sprite:getChildByTag(Const.ANI_SP_TAG)
	sp:stopAllActions()
	sp:runAction(CCRepeatForever:create(CCAnimate:create(ResMgr.getAni(aniName))))
end
