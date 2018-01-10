local Main = {}

local SceneGroup = require('Services.SceneGroup')
local Screen = require('Device.Screen')
local State = require('Game.State')

local Scroll = require('Runtime.Scroll')
local Row = require('Runtime.Row')

Main.runAll = function()
  SceneGroup.forEach(State.sceneGroup, function(obj)
		Scroll.single(obj, 'y')
		Row.remover(obj)
  end)
end

Main.init = function()
	Runtime:addEventListener( "enterFrame", Main.runAll)
	-- Runtime:addEventListener( "enterFrame", Scroll.scene('y', State.sceneGroup) )
	-- Runtime:addEventListener( "enterFrame", Row.remover(State.sceneGroup) )
end


return Main