local Main = {}

local SceneGroup = require('Services.SceneGroup')
local Screen = require('Device.Screen')
local State = require('Game.State')

local Scroll = require('Runtime.Scroll')
local Row = require('Runtime.Row')
local ExtraObj = require('Runtime.ExtraObj')
local Config = require('Game.Config')

Main.runAll = function()
  SceneGroup.forEach(State.sceneGroup, function(obj)
		Scroll.single(obj, 'y')

		if(Config.levelBuilder == false) then
			Row.remover(obj)
			ExtraObj.remover(obj)
		end
  end)
end

Main.init = function()
	Runtime:addEventListener( "enterFrame", Main.runAll)
end


return Main