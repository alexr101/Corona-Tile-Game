local Scroll = {}
local Config = require('Game.Config')

Scroll.single = function(obj, axis)
		obj[axis] = obj[axis] - Config.levelSpeed
end

-- Find method to get all running event listeners
-- so they can be removed on scene:destroy
function Scroll.scene(axis, sceneGroup)
	return function() _scroll(axis, sceneGroup) end
end

return Scroll