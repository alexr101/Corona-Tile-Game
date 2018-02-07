local EventListeners = {}

local function moveMap( event )

	if(Config.levelBuilder) then
		Grid.forEach(function(element)
			local newTouchY = event.y
				
			if (event.phase == "began") or (element.lastTouchPosY == nil) then
				element.lastTouchPosY = newTouchY
				return
			end
			if (event.phase == "ended") or (event.phase == "cancelled") then
				element.lastTouchPosY = nil
				return
			end

			local deltaY = (newTouchY - element.lastTouchPosY)
			element.y = element.y + deltaY
			element.lastTouchPosY = newTouchY
		end)
	end
	
end	

EventListeners.init = function()
	-- AppState.sceneGroup:addEventListener( "touch", moveMap ) 
end

return EventListeners