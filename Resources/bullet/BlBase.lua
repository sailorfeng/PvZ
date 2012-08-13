-- ×Óµ¯Àà
-- by f.f.

module(..., package.seeall)

local PzObj = require("PzObj")
BlBase=class(PzObj.PzObj)

function BlBase:ctor()
	self.type = PzObj.BULLET_TYPE
	self.x = 0
	self.y = 0
end

function BlBase:initPos(x,y)
	self.x = x
	self.y = y
	self.sprite:setPosition(math.floor(self.x),math.floor(self.y))
end
