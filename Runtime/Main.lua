
-----------------------------------------------------------------------------------------
--
-- Handles all Run time Operations
--
-----------------------------------------------------------------------------------------

local Main = {}

local SceneGroup = require('Services.SceneGroup')
local Screen = require('Device.Screen')
local State = require('Game.State')

local Scroll = require('Runtime.Scroll')
local Row = require('Runtime.Row')
local FreeFloatingObj = require('Runtime.FreeFloatingObj')
local Enemy = require('Runtime.Enemy')
local ZOrdering = require('Runtime.ZOrdering')

local Config = require('Game.Config')

-- In charge of running all runtime functions through the group
Main.sceneGroupLoop = function()
  SceneGroup.forEach(State.sceneGroup, function(obj)
		Scroll.single(obj, 'y')
		Enemy.movement(obj)
		
		if(Config.levelBuilder.activated == false) then
			Row.remover(obj)
			FreeFloatingObj.remover(obj)
		end
  end)
end

-- Starts a runtime event with the main runAll functions
Main.init = function(options)
	Runtime:addEventListener( "enterFrame", Main.sceneGroupLoop)

	if(options) then
		if(options.ZOrderGroups) then
			local orderFn = function() ZOrdering.order(options.ZOrderGroups) end
			Runtime:addEventListener("enterFrame", orderFn)
		end
	end
end

Main.removeAll = function()
	Runtime:removeEventListener( "enterFrame", Main.sceneGroupLoop)
	local orderFn = function() ZOrdering.order(options.ZOrderGroups) end
	Runtime:removeEventListener("enterFrame", orderFn)
end



return Main