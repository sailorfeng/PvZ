-- PvZ obj base class
-- by f.f.

module(..., package.seeall)
PzObj=class()
PLANT_TYPE="plant"
ZOMBIE_TYPE="zombie"
BULLET_TYPE="bullet"

function PzObj:ctor()
	self.id = ResMgr.genGbId()
	self.fsm = {} 	-- use by FSM module
end

function PzObj:hurt(drop)
	self.hp = self.hp - drop
	-- TODO: die
end

function PzObj:myLine()
	return findObjLine(self)
end
