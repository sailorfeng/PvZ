-- “∆∂Ø¿‡
-- by f.f.

module(..., package.seeall)

function uniformMove(self)
	self.x = self.x + self.speedX
	self.y = self.y + self.speedY
	self.sprite:setPosition(math.floor(self.x),math.floor(self.y))
end

