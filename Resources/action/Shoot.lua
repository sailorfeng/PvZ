-- ¿ª»ðÀà
-- by f.f.

module(..., package.seeall)
local Bean = require("bullet.Bean")
local Sun = require("utils.Sun")
local UI = require("stage.UI")
local SHOOT_CD = 300
function oneBean(self)
	if self.shootCd == nil then self.shootCd = SHOOT_CD*0.8 end
	self.shootCd = self.shootCd + 1
	if self.shootCd >= SHOOT_CD then
		self.shootCd = 0
		local bl = Bean.new()
		bl:initPos(self.x+20, 0)
		self:myLine():add(bl)
	end
end

local SUN_CD = 500
function createSun(self)
	if self.sunCd == nil then self.sunCd = SUN_CD*0.8 end
	self.sunCd= self.sunCd+ 1
	if self.sunCd >= SUN_CD then
		self.sunCd = 0
		local glbPos = self.sprite:convertToWorldSpace(CCPointMake(0, 0))
		local sun = Sun.new()
		sun:initPath(glbPos.x, glbPos.y + 50, glbPos.y - 30)
		UI.addTouchObj(sun)
	end
end
