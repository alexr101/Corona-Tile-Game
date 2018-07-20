-----------------------------------------------------------------------------------------
--
-- Scrolling Objects Functionality
--
-----------------------------------------------------------------------------------------

local Scroll = {}

-- Move a single object
Scroll.single = function(obj, axis)
		obj[axis] = obj[axis] - Config.levelSpeed
end

return Scroll