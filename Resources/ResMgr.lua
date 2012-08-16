-- ×ÊÔ´Ä£¿é
-- by f.f.

module(..., package.seeall)

local aniInited = {}

local aniConf = {
	ZbSimple={ path=rpath("ZbSimple", "Zombie"), frame=12 },
	ZbSimpleAttack={ path=rpath("ZbSimple", "Zombie"), frame=21, sep=0.1 },
	PeaShooterStand={ path=rpath("PeaShooter", "Plant"), frame=10, sep=0.1 },
	PeaShooterFire={ path=rpath("PeaShooter", "Plant"), frame=9 },
	Sun={ path=rpath("Sun"), frame=22, sep=0.1 },
	SunFlower={ path=rpath("SunFlower", "Plant"), frame=18 },
}

local imgConf = {
	rpath("etc"),
	rpath("Card")
}

local loadedPlist = {}

function getAni(name)
	local conf = aniConf[name]
	if conf == nil then
		print("getAni err:"..name)
		return nil
	end

	if aniInited[name] == nil then
		local cache = CCSpriteFrameCache:sharedSpriteFrameCache()
		if loadedPlist[conf.path] == nil then
			cache:addSpriteFramesWithFile(conf.path..".plist", conf.path..".png")
			loadedPlist[conf.path] = true
		end

		local animFrames = CCMutableArray_CCSpriteFrame__:new(conf.frame)
		local fname = ""
		for i = 0, conf.frame-1 do
			if i < 10 then fname = "0"..i else fname = i end
			animFrames:addObject(cache:spriteFrameByName(name..fname..".png"));
		end

		local ani = CCAnimation:animationWithFrames(animFrames, conf.sep or 0.2)
		CCAnimationCache:sharedAnimationCache():addAnimation(ani, name)
		aniInited[name] = true
	end
	return CCAnimationCache:sharedAnimationCache():animationByName(name)
end

function getAniFaceFrame(name)
	local cache = CCSpriteFrameCache:sharedSpriteFrameCache()
	if aniInited[name] == nil then getAni(name) end
	return cache:spriteFrameByName(name.."00.png")
end

local objId = 0
function genGbId()
	objId = objId + 1
	return objId
end

for i, path in ipairs(imgConf) do
	local cache = CCSpriteFrameCache:sharedSpriteFrameCache()
	if loadedPlist[path] == nil then
		cache:addSpriteFramesWithFile(path..".plist", path..".png")
		loadedPlist[path] = true
	end
end

function getImageFrame(name)
	return CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName(name..".png")
end
