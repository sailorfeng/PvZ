-- res path define
-- by f.f.

local res_path = "res"

function rpath(file, dir) 
	if dir == nil then
		return res_path.."/"..file
	else
		return res_path.."/"..dir.."/"..file;
	end
end
