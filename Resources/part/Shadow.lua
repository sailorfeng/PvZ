-- Shadow part

module(..., package.seeall)
require("ResMgr")
require("Const")

NORMAL_SHADOW = "plantShadow"
BEAN_SHADOW = "peaShadow"

function attatch(obj, sdName, posX, posY)
	local shd = CCSprite:createWithSpriteFrame(ResMgr.getImageFrame(sdName))
	shd:setPosition(posX, posY)
	obj.sprite:addChild(shd, -1, Const.SHADOW_SP_TAG)
end
