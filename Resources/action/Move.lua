-- “∆∂Ø¿‡
-- by f.f.

module(..., package.seeall)
local Coor = require("utils.Coor")

function uniformMove(self)
	self.x = self.x + self.speedX
	self.y = self.y + self.speedY
	self.sprite:setPosition(math.floor(self.x),math.floor(self.y))
end

function moveToPos(self)
	local len = Coor.distance(CCPointMake(self.x, self.y), CCPointMake(self.toX, self.toY))
--	print("before", self.x, self.y)
	if len < 1 then
		self.x = self.toX
		self.y = self.toY
	else
		self.x = self.x + (self.toX - self.x) / len * self.speed
		self.y = self.y + (self.toY - self.y) / len * self.speed
	end
--	print("after", self.x, self.y)

	self.sprite:setPosition(math.floor(self.x), math.floor(self.y))
end
