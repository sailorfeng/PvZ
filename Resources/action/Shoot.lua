-- ¿ª»ðÀà
-- by f.f.

module(..., package.seeall)
local Bean = require("bullet.Bean")
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

