-- Zombie base class
-- by f.f.

module(..., package.seeall)

local PzObj = require("PzObj")
ZbBase=class(PzObj.PzObj)

function ZbBase:ctor()
	self.type = PzObj.ZOMBIE_TYPE
	self.x = 0
	self.y = 0
	self.speedX = 0
	self.speedY = 0
end

function ZbBase:eat()
	print("ZbBase eat")
end

function ZbBase:initPos(x,y)
	self.x = x
	self.y = y
	self.sprite:setPosition(math.floor(self.x),math.floor(self.y))
end
