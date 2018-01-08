local Scroll = {}
local Config = require('Game.Config')

function _scroll(axis, sceneGroup)
	local numChildren = #sceneGroup;
	local SceneGroup = require('Services.SceneGroup')

	if(#sceneGroup == 0) then numChildren = sceneGroup.numChildren end

	SceneGroup.forEach(sceneGroup, function(obj)
		obj[axis] = obj[axis] - Config.levelSpeed
	end)

end

-- Find method to get all running event listeners 
-- so they can be removed on scene:destroy
function Scroll.scene(axis, sceneGroup)
	return function() _scroll(axis, sceneGroup) end
end

return Scroll