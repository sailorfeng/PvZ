--  ‹…À¿‡
-- by f.f.

module(..., package.seeall)

function bulletHit(self)
	print("bulletHit")
	local zb = findObjById(self.hitZb)
	zb:hurt(self.power)
	self:myLine():del(self)
end

function eatPlant(self)

end
