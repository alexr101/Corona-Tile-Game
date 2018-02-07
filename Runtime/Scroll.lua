local Scroll = {}

Scroll.single = function(obj, axis)
		obj[axis] = obj[axis] - Config.levelSpeed
end

return Scroll