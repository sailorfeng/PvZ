-- ÊÜÉËÀà
-- by f.f.

module(..., package.seeall)

local Life = require("part.Life")
function bulletHit(self)
--	print("bulletHit")
	local zb = findObjById(self.hitZb)
	Life.hurt(zb, self.power)
	self:myLine():del(self)
end

function bulletHitKeep(self)
--	print("bulletHit")
	local zb = findObjById(self.hitZb)
	Life.hurt(zb, self.power)
end

function bulletExp(self)
	if self.expTime then return end
	local expPart = CCParticleSystemQuad:create(rpath("BeanExplosion.plist"))
	expPart:setPosition(10,0)
--	expPart:setTextureWithRect(CCTextureCache:sharedTextureCache():addImage(rpath("BeanParticle.png")), CCRectMake(0,0,11,10))
	self.sprite:removeAllChildrenWithCleanup(true)
	self.sprite:addChild(expPart, 10)
end

function eatPlant(self)
	if self.eatCd == nil then self.eatCd = 0 end
	if self.eatCd > 100 then
		local pl = findObjById(self.eatPlant)
		Life.hurt(pl, self.power)
		self.eatCd = 0
	end
	self.eatCd = self.eatCd+1
end
