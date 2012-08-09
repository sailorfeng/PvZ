-- Zombie base class
-- by f.f.

module(..., package.seeall)

ZbBase=class()

local zbId = 0
function ZbBase:ctor()
	zbId = zbId + 1
	self.id = zbId
	self.x = 0
	self.y = 0
	self.speedX = 0
	self.speedY = 0
end

function ZbBase:walk()
	self.x = self.x + self.speedX
	self.y = self.y + self.speedY
	self.sprite:setPosition(math.floor(self.x),math.floor(self.y))

--	print("ZbBase walk")
end

function ZbBase:eat()
	print("ZbBase eat")
end

function ZbBase:initPos(x,y)
	self.x = x
	self.y = y
	self:walk()
end
