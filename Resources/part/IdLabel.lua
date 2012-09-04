-- show id

module(..., package.seeall)

function attatch(obj)
	obj.idLabel = CCLabelTTF:create(obj.id, "Arial", 20)
	obj.idLabel:setPosition(0, 70)
	obj.idLabel:setColor(ccc3(255,0,0))
	obj.sprite:addChild(obj.idLabel, 100)
end
