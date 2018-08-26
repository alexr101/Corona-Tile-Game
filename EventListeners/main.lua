local EventListeners = {}

-- This allow you to move the map by dragging. Only usable on levelBuilder
-- Loop through the GRID elements
-- If you move the Grid itself BoxPhysics won't move
local function moveMap( event )
	if(Config.levelBuilder.) then
		Grid.forEach(function(element)
			if (event.phase == "began") then
				element.startEventY = event.y
				element.startElementY = element.y
			end

			if (event.phase == "ended") or (event.phase == "cancelled") then
				return
			end

			local deltaY = element.startEventY - event.y
			element.y = element.startElementY - deltaY
		end)
	end
end	

EventListeners.init = function()
	AppState.sceneGroup:addEventListener( "touch", moveMap ) 
end

return EventListeners