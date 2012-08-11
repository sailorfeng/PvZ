-- Ö²Îï»ùÀà
-- by f.f.

module(..., package.seeall)

local PzObj = require("PzObj")
PlBase=class(PzObj.PzObj)

function PlBase:ctor()
	self.type = PzObj.PLANT_TYPE
	self.x = 0
	self.y = 0
end

function PlBase:initPos(x,y)
	self.x = x
	self.y = y
	self.sprite:setPosition(math.floor(self.x),math.floor(self.y))
end
