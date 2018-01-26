local composer = require( "composer" )
			composer.removeScene( "Menu" )
local scene = composer.newScene()
local Config = require('Game.config')

  physics = require "physics"
			physics.start()
			physics.setGravity( 0, 9.81)  -- 9.81 m/s*s in the positive x direction  


if(Config.debug) then
	physics.setDrawMode( "hybrid" )
else
	physics.setDrawMode( "normal" )
end

local Graphics = require('UI.graphics')
local Math = require('Utils.math')
-- local Memory = require('Device.Memory')
local Screen = require('Device.Screen')
local Table = require('Utils.Table')
local zOrdering = require('UI.ZOrdering')
local Player = require('Game.Player')
AppState = require('Game.State')

local Node = require('Game.Map.Node')
local GameTables = require('Game.Tables')

local Sprites = require('Sprites.Sprites')

local AppContext = {}
local timerTable = {}



function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	local sceneGroup = self.view
	AppState.sceneGroup = sceneGroup

	-- Player = {}
	-- Player.instance = {}
    -- Player.instance = display.newImageRect("assets/game-objects/player.png", tileSize, tileSize )
	-- Player.instance.x = Screen.width * .58
	-- Player.instance.y = Screen.height * .23
	-- physics.addBody( Player.instance, { density = 1, friction=1, bounce=0, radius=tileSize*.3 } )
	-- Graphics.radiate(player,{
	-- 	alphaLow = .7,
	-- 	alphaHigh = 1,
	-- 	speedGlow = 1000,
	-- 	speedDimmer = 500,
	-- })
	-- Player.isFixedRotation = true
	-- Player.isSleepingAllowed = false
	-- Player.isBullet = true
	-- Player.xScale = 1 
	-- Player.yScale = 1



	itemsGroup = display.newGroup()
	blackTiles = display.newGroup()

	local Grid = require('Game.Map.Grid')
	local GameCollisions = require('Physics.Collisions')

	-- local options1 = 
	-- {
	--     text = orbs,
	--     width = 120,     --required for multi-line and alignment
	--     align = "left",
	--     font = native.systemFont,
	--     fontSize = 18
	-- }
	-- orbText = display.newText( options1 )
	-- orbText:setFillColor( 1, 1, 1 )
	-- orbText.x = Screen.width*.26
	-- orbText.y = Screen.height*.05
	-- orbText.gui = true

	local horizontalRowLength = 6
	local tileSize = Screen.width / horizontalRowLength
	
	player = Player.new(tileSize)
	
	local matrix = Grid.create(sceneGroup)
	Grid.update()
	-- Grid.addNodesToMatrix()

	-- Table.forEach(GameTables.tiles, function(element)
	-- 	local ElectricityBehavior = require('Game.Behaviors.ElectricityGenerator')
	-- 	if(element.info.name == 'ElectricityGenerator') then
	-- 		ElectricityBehavior.updateElectricity({
	-- 			row = element.coordinates.row, 
	-- 			column = element.coordinates.column
	-- 		})

	-- 	end
	-- end)

	-- TODO: move every single object through a loop...
	local function touchListener( event )

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
		
	AppState.sceneGroup:addEventListener( "touch", touchListener ) 


	-- AppState.currentGame.sceneGroup:insert(player)
	-- sceneGroup:insert( player )	
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if phase == "will" then	

	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.

		-- function returnPlayerToCenter()
		-- 	player.y = player.y - 1
		-- end

		-- Runtime:addEventListener("enterFrame", returnPlayerToCenter)

		local layers = {
			[1] = itemsGroup,
			[2] = blackTiles,
			[3] = player,
			[4] = orbText,
			[5] = player
		}

		zOrdering.order(layers)

		local RuntimeMain = require('Runtime.Main')
		RuntimeMain.init()


	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene