-- PvZ obj base class
-- by f.f.

module(..., package.seeall)
PzObj=class()
PLANT_TYPE="plant"
ZOMBIE_TYPE="zombie"
BULLET_TYPE="bullet"
SUN_TYPE="sun"

function PzObj:ctor()
	self.id = ResMgr.genGbId()
	self.fsm = {} 	-- use by FSM module
end

function PzObj:myLine()
	return findObjLine(self)
end

function PzObj:die()
--	print("obj:"..self.id.." type:"..self.type.." die")
	self:myLine():del(self)
end
