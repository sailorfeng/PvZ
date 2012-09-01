-- ×î¼òµ¥µÄ½©Ê¬
-- by f.f.

module(..., package.seeall)

local ZbBase = require("zombie.ZbBase")
require("ResMgr")
local FSM = require("utils.FSM")
local Coor = require("utils.Coor")
local Move = require("action.Move")
local Hurt = require("action.Hurt")
local Life = require("part.Life")
local Ani = require("part.Ani")
local IdLabel = require("part.IdLabel")
local Shadow = require("part.Shadow")
ZbSimple=class(ZbBase.ZbBase)

function new(...) return ZbSimple.new(...) end

function ZbSimple:ctor()
	self.name = "ZbSimple."..self.id

	self.sprite = CCLayer:create()
	Shadow.attatch(self, Shadow.NORMAL_SHADOW, 10, -50)

	local sp = CCSprite:createWithSpriteFrame(ResMgr.getAniFaceFrame("ZbSimple"))
	self.sprite:addChild(sp, 0, Const.ANI_SP_TAG)
	Ani.attatch(self,"ZbSimple")

	Life.attatch(self)
	self.speedX = -0.1
	self.power = 10

	IdLabel.attatch(self)

	FSM.set(self, "ZSS_WALK")
end

local FSM_INFO = {
	ZSS_WALK={
		function(self)
			local grid = Coor.x2Grid(self.x)
			if self:myLine() == nil then return nil end
			local pl = self:myLine():getPlantByGrid(grid)
			if pl ~= nil then
				self.eatPlant = pl.id
				return "ZSS_EAT"
			end
		end,
		deal=function(self)
			if FSM.last(self) == "ZSS_EAT" then 
				Ani.attatch(self, "ZbSimple")
			end
			Move.uniformMove(self)
		end
	},
	ZSS_EAT={
		function(self)
			local grid = Coor.x2Grid(self.x)
			if self:myLine() ~= nil and self:myLine():getPlantByGrid(grid) == nil then return "ZSS_WALK" end
		end,
		deal=function(self)
			if FSM.last(self) == "ZSS_WALK" then
				Ani.attatch(self, "ZbSimpleAttack")
			end
			Hurt.eatPlant(self)
		end
	},
}

function ZbSimple:update()
	FSM.run(self, FSM_INFO)
--	if self.id == 5 then print("zb 5 stat:"..FSM.curr(self)) end
end
