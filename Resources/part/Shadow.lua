-- Shadow part

module(..., package.seeall)
require("ResMgr")
require("Const")

NORMAL_SHADOW = "plantShadow"
BEAN_SHADOW = "peaShadow"

function attatch(obj, sdName, posX, posY)
	obj.shd = CCSprite:createWithSpriteFrame(ResMgr.getImageFrame(sdName))
	obj.shd:setPosition(posX, posY)
	obj.sprite:addChild(obj.shd, -1, Const.SHADOW_SP_TAG)
end
