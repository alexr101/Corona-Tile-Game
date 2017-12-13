local scene = {}

local config = require('game.Config')

scene.width = display.actualContentWidth
scene.height = display.actualContentHeight
scene.halfW = display.contentCenterX
scene.halfH = display.contentCenterY
scene.originX = display.screenOriginX
scene.originY = display.screenOriginY
scene.actualContentWidth = display.actualContentWidth
scene.actualContentHeight = display.actualContentHeight

function _scroll(axis, sceneGroup)
	local numChildren = #sceneGroup;

	if(#sceneGroup == 0) then numChildren = sceneGroup.numChildren end

	for i = numChildren, 1, -1 do
		local obj = sceneGroup[i]
		if obj ~= nil and obj.gui ~= true then
 			obj[axis] = obj[axis] - config.levelSpeed
		end
	end
end

-- Find method to get all running event listeners 
-- so they can be removed on scene:destroy
function scene.move(axis, sceneGroup)

	local moveFn = function() _scroll(axis, sceneGroup) end
	Runtime:addEventListener( "enterFrame", moveFn )
end

return scene