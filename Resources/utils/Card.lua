-- ¿¨Æ¬
-- by f.f.
module(..., package.seeall)

local PzObj = require("PzObj")
local ResMgr = require("ResMgr")
local FSM = require("utils.FSM")

local CARD_INFO = {
	PeaShooter={ sun=100, cd=500, model="PeaShooterStand" },
	SunFlower={ sun=50, cd=400, model="SunFlower" },
}

Card=class(PzObj.PzObj)
function new(name)
	if CARD_INFO[name] == nil then print("create card err!") end
	return Card.new(name)
end

function Card:ctor(name)
	self.name = name
	local info = CARD_INFO[name]

--	self.sprite = CCLayer:node()
--	local shd = CCSprite:spriteWithSpriteFrame(ResMgr.getImageFrame(name))
--	self.sprite:addChild(shd)
	self.sprite = CCSprite:spriteWithSpriteFrame(ResMgr.getImageFrame(name))

	self.cdBar = CCProgressTimer:progressWithFile(rpath(name.."G.png", "Card"))
	self.cdBar:setPosition(50, 30)
	self.cdBar:setType(kCCProgressTimerTypeVerticalBarBT)
	self.cdBar:setPercentage(0)
	self.sprite:addChild(self.cdBar)

	local sunLabel = CCLabelTTF:labelWithString(info.sun, "Arial", 5)
	sunLabel:setPosition(70, 10)
	self.sprite:addChild(sunLabel)

	local sunIcon = CCSprite:spriteWithSpriteFrame(ResMgr.getImageFrame("SmallSun"))
	sunIcon:setPosition(90, 10)
	self.sprite:addChild(sunIcon)

	FSM.set(self, "CARD_UNABLE");
	self.cdCnt = 0
end

local FSM_INFO = {
	CARD_OK={
		function(self)
			if getScore() < CARD_INFO[self.name].sun then return "CARD_UNABLE" end
			if self.cdCnt > 0 then return "CARD_CDING" end
			return nil
		end,
		deal=function(self)
			self.cdBar:setPercentage(0)
		end
	},
	CARD_CDING={
		function(self)
			if self.cdCnt <= 0 then return "CARD_OK" end
			return nil
		end,
		deal=function(self)
			self.cdBar:setPercentage(math.floor(self.cdCnt/CARD_INFO[self.name].sun))
			self.cdCnt = self.cdCnt - 1
		end
	},
	CARD_UNABLE={
		function(self)
			if getScore() >= CARD_INFO[self.name].sun then
				if self.cdCnt > 0 then return "CARD_CDING" end
				return "CARD_OK"
			end
		end,
		deal=function(self)
			self.cdBar:setPercentage(100)
		end
	},
}

function Card:update()
	FSM.run(self, FSM_INFO)
end

function Card:onTouch(eventType, x, y)	
	if FSM.curr(self) ~= "CARD_OK" then return end
	setSelectedPlant(self.name)
end

function Card:startCD()
	FSM.set(self, "CARD_CDING");
	set.cdCnt = CARD_INFO[self.name].cd
end

function Card:reset()
	self.cdBar:setPercentage(0)
	self.cdCnt = 0
end

local card_list = {}
function getCard(name)
	if card_list[name] == nil then 
		local c = Card.new(name)
		card_list[name] = c
	end
	return card_list[name]
end

function getCardModel(name)
	return CARD_INFO[name].model
end

function isCardOK(name)
	return FSM.curr(card_list[name]) == "CARD_OK"
end

function getCostSun(name) return CARD_INFO[name].sun end
