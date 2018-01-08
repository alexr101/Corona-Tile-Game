local Main = {}
local State = require('Game.State')
local Scroll = require('Runtime.Scroll')
local Row = require('Runtime.Row')

Main.init = function()
	Runtime:addEventListener( "enterFrame", Scroll.scene('y', State.sceneGroup) )
	-- Runtime:addEventListener( "enterFrame", Row.remover(State.sceneGroup) )
end


return Main