-- show id

module(..., package.seeall)

function attatch(obj)
	local idLabel = CCLabelTTF:create(obj.id, "Arial", 20)
	idLabel:setPosition(0, 70)
	idLabel:setColor(ccc3(255,0,0))
	obj.sprite:addChild(idLabel, 100)
end
