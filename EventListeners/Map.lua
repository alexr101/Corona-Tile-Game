local Map = {}

-- This allow you to move the map by dragging. Only usable on levelBuilder
-- Loop through the GRID elements
-- If you move the Grid itself BoxPhysics won't move
Map.moveMap = function( event )
	if(Config.levelBuilder.activated) then
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

return Map