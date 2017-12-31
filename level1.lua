local composer = require( "composer" )
			composer.removeScene( "menu" )
local scene = composer.newScene()
local Config = require('game.config')

local physics = require "physics"
			physics.start(true)
if(Config.debug) then
	physics.setDrawMode( "hybrid" )
else
	physics.setDrawMode( "normal" )
end

local Collision = require('modules.Collision')
local Graphics = require('modules.Graphics')
local Math = require('modules.Math')
local Memory = require('modules.Memory')
local Screen = require('modules.Screen')
local Table = require('modules.Table')
local ViewLayers = require('modules.ViewLayers')

local GameCollisions = require('game.Collisions')
local Grid = require('game.Grid')
local Node = require('game.Node')
local GameTables = require('game.tables')
local Tiles = require('game.Tiles')

local Sprites = require('sprites.Sprites')

local AppContext = {}
local timerTable = {}

function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view
	itemsGroup = display.newGroup()
	blackTiles = display.newGroup()




	orbs = 0
	gameSpeed = 1.2

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


	

		-- basic measurements and setup
	local horizontalRowLength = 6
	local tileSize = Screen.width / horizontalRowLength
	local verticalRowLength = (Screen.height / tileSize) + 1

	-- local electricity = display.newSprite( Sprites.electricity.sheet , Sprites.electricity.sequence )
	-- electricity:setSequence( "Electricity" )
	-- electricity:play()
	-- local electricitySize = .3
	-- electricity.xScale = electricitySize
	-- electricity.yScale = electricitySize
	-- electricity.rotation = 90
	-- electricity.x = 50
	-- electricity.y = 50
	-- physics.addBody( electricity, "static", { friction=0.5, bounce=0.3 } )	
	-- electricity.isSensor = true
	-- electricity.collision = onElectricityCollision
	-- electricity:addEventListener( "collision" )


	

	player = display.newImageRect("images/game-objects/player.png", tileSize, tileSize )
	player.x = Screen.width * .58
	player.y = Screen.height * .23
	physics.addBody( player, "dynamic", { friction=1, bounce=0.3, radius=tileSize*.3 } )
	Graphics.radiate(player, {
		alphaLow = .7,
		alphaHigh = 1,
		speedGlow = 1000,
		speedDimmer = 500,

	})
	
	-- all display objects must be inserted into group

	local matrix = Grid.create(sceneGroup)
	Grid.addNodesToMatrix()

	Table.forEach(GameTables.tiles, function(element)
		-- print(element)
	end)


 	-- sceneGroup:insert( orbText )
	sceneGroup:insert( player )
	
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

		function returnPlayerToCenter()
			player.y = player.y - 1
		end

		Runtime:addEventListener("enterFrame", returnPlayerToCenter)

		local layers = {
			[1] = itemsGroup,
			[2] = blackTiles,
			[3] = player,
			[4] = orbText,
			[5] = player
		}

		ViewLayers.order(layers)

		Screen.move('y', sceneGroup)

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