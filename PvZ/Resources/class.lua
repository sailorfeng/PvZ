-- luaÄ£ÄâµÄÀà
-- http://blog.codingnow.com/cloud/LuaOO
-- by cloudwu

local _class={}
 
function class(superclass)
	local class_type={}
	class_type.ctor=false
	class_type.superclass=superclass
	class_type.super=_class[superclass]
	class_type.new=function(...) 
			local obj={}
			do
				local create
				create = function(c,...)
					if c.superclass then
						create(c.superclass,...)
					end
					if c.ctor then
						c.ctor(obj,...)
					end
				end
 
				create(class_type,...)
			end
			setmetatable(obj,{ __index=_class[class_type] })
			return obj
		end
	local vtbl={}
	_class[class_type]=vtbl
 
	setmetatable(class_type,{__newindex=
		function(t,k,v)
			vtbl[k]=v
		end
	})
 
	if superclass then
		setmetatable(vtbl,{__index=
			function(t,k)
				local ret=_class[superclass][k]
				vtbl[k]=ret
				return ret
			end
		})
	end
 
	return class_type
end
