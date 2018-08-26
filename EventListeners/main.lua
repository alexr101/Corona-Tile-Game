local EventListeners = {}
local Map = require('EventListeners.Map')

EventListeners.init = function()
	AppState.sceneGroup:addEventListener( "touch", Map.moveMap ) 
end

EventListeners.removeAll = function()
	AppState.sceneGroup:removeEventListener( "touch", Map.moveMap ) 
end

return EventListeners