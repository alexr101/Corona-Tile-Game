local composer = require( "composer" )
local scene = composer.newScene()
composer.removeScene( "menu" )

local physics = require "physics"
physics.start(true)
physics.setDrawMode( "normal" )

local sprites = require('sprites.sprites');
local math = require('modules.math')
local collision = require('modules.collision')
local gameCollisions = require('game.collisions')
local screen = require('modules.screen')
local swipe = require('modules.swipe')
local viewLayers = require('modules.viewLayers')
local graphics = require('modules.graphics')
local memory = require('modules.memory')
local node = require('game.node')
-- memory.print()

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

	local options1 = 
	{
	    text = orbs,
	    width = 120,     --required for multi-line and alignment
	    align = "left",
	    font = native.systemFont,
	    fontSize = 18
	}
	orbText = display.newText( options1 )
	orbText:setFillColor( 1, 1, 1 )
	orbText.x = screen.width*.26
	orbText.y = screen.height*.05

	local star = display.newSprite( sprites.star.sheet , sprites.star.sequence)
	star:setSequence( "StarPic" )
	star:play()

	star.x = screen.width*.05
	star.y = 20

	local newNode = node.new('1')
	print(newNode.val)

	local starSize = .5
	star.xScale = starSize
	star.yScale = starSize

		-- basic measurements and setup
	local horizontalRowLength = 6
	local tileSize = screen.width / horizontalRowLength
	local verticalRowLength = (screen.height / tileSize) + 1

	local electricity = display.newSprite( sprites.electricity.sheet , sprites.electricity.sequence )
				electricity:setSequence( "Electricity" )
				electricity:play()

	local electricitySize = .3
				electricity.xScale = electricitySize
				electricity.yScale = electricitySize
				electricity.rotation = 90

				electricity.x = 50
				electricity.y = 50

				physics.addBody( electricity, "static", { friction=0.5, bounce=0.3 } )	
				electricity.isSensor = true
				electricity.collision = onElectricityCollision
				electricity:addEventListener( "collision" )

	local tile_Horizontal = display.newImageRect("images/game-objects/rockTile.jpg", tileSize, tileSize)
				tile_Horizontal.x = 500
				tile_Horizontal.y = 300
	
	local mineMagnet = display.newImageRect("images/game-objects/mine.png", tileSize*.6, tileSize*.6)
				mineMagnet.x = 150
				mineMagnet.y = 150
				physics.addBody( mineMagnet, "dynamic", { friction=0.5, bounce=0.3, radius=15 } )	
				mineMagnet.gravityScale = 0
				mineMagnet.collision = onMineCollision
				mineMagnet:addEventListener( "collision" )


	-- create a grey rectangle as the backdrop
	local background = display.newRect( 0, 0, screen.width, screen.height )
	background.anchorX = 0
	background.anchorY = 0
	background:setFillColor( 0, 0, 0 )

	tileTable = {}
	enemyTable = {}
	itemTable = {}
	orbTable = {}

	player = display.newImageRect("images/game-objects/player.png", tileSize, tileSize )
	player.x = screen.width * .58
	player.y = screen.height * .23

	physics.addBody( player, "dynamic", { friction=1, bounce=0.3, radius=tileSize*.3 } )
	graphics.radiate(player)
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )

	for i = #tileTable, 1, -1 do

	end
	sceneGroup:insert( mineMagnet )
 	sceneGroup:insert( orbText )
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

		viewLayers.order(layers)

		screen.move('x', sceneGroup)

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