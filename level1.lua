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


-----------------------------------------------------------------------------------------------

local timerTable = {}

-- forward declarations and other locals
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5
--[[
local printMemUsage = function()  
    local memUsed = (collectgarbage("count"))
    local texUsed = system.getInfo( "textureMemoryUsed" ) / 1048576 -- Reported in Bytes
   
    print("\n---------MEMORY USAGE INFORMATION---------")
    print("System Memory: ", string.format("%.00f", memUsed), "KB")
    print("Texture Memory:", string.format("%.03f", texUsed), "MB")
    print("------------------------------------------\n")
end

Runtime:addEventListener( "enterFrame", printMemUsage)
]]--

--STARS, SMOKE, LIGHTNING BAR





-- I think self is the touched object
-- TODO: verify this
function swipeHandler(self, event)
	local swipeOffset = 50

	if ( event.phase == "began" ) then
        -- Set touch focus
        display.getCurrentStage():setFocus( self )
        self.isFocus = true
    end

    if (event.phase == "ended") then

    	yEnd = event.y
    	xEnd = event.x

    	if     xEnd > event.xStart + swipeOffset then
    		-- right

    	elseif xEnd < event.xStart - swipeOffset then
    		-- left

    	elseif yEnd < event.yStart - swipeOffset then
    		-- up

    	elseif yEnd > event.yStart + swipeOffset then
    		-- down

    	end

    	-- Reset touch focus
      display.getCurrentStage():setFocus( nil )
      self.isFocus = nil
    end
end





function createRow(horizontalRowLength, tileSize, yPoint, sceneGroup)		

	local createdOneElectricity = false

	for i = 1, horizontalRowLength, 1 do

		-- <5 = blank, 6 = black
		tileType = math.random(0, 4)
		tileX = (i - .5) * tileSize
		tileY = yPoint

		if tileType <= 2 then
			tile_Horizontal = display.newRect(tileX, tileY, tileSize, tileSize + 2)
			tile_Horizontal:setFillColor( 0, 0, 0 )
			tile_Horizontal.empty = true
		else
			tile_Horizontal = display.newImageRect("images/game-objects/rockTile.jpg", tileSize, tileSize)
			tile_Horizontal.x = (i - .5) * tileSize
			tile_Horizontal.y = tileY
			blackTiles:insert( tile_Horizontal )
		end

		tile_Horizontal.column = i
		currentColumn = currentColumn + 1

		tile_Horizontal.row = rowNumber
		tile_Horizontal.id = tileId

		tileId = tileId + 1

		--Insert tile to table
		tile_Horizontal.touch = onTileTouch
		tile_Horizontal:addEventListener( "touch", tile_Horizontal )

		if tileType >= 3 then
			tile_Horizontal.collision = onTileCollision
			tile_Horizontal:addEventListener( "collision" )
			physics.addBody( tile_Horizontal, "static", { friction=0.5, bounce=0.3 } )	
		else
			randomNumber = math.random(10)
			if randomNumber < 3 then
				--local star = display.newSprite( spriteSheet1, sequenceData1 )
				local star = display.newSprite( sprites.star.sheet , sprites.star.sequence)
				star:setSequence( "Star" )
				star:play()

				star.x = tile_Horizontal.x
				star.y = tile_Horizontal.y

				physics.addBody( star, "static", { friction=0.5, bounce=0.3, radius=10 } )	
				star.isSensor = true
				star.collision = onOrbCollision
				star:addEventListener( "collision" )

				tile_Horizontal.containsItem = true
				tile_Horizontal.item = star
			elseif randomNumber == 4 then
				mineMagnet = display.newImageRect("images/game-objects/mine.png", tileSize*.6, tileSize*.6)
				mineMagnet.x = tile_Horizontal.x
				mineMagnet.y = tile_Horizontal.y
				physics.addBody( mineMagnet, "dynamic", { friction=0.5, bounce=0.3, radius=15 } )	
				mineMagnet.gravityScale = 0
				mineMagnet.collision = onMineCollision
				mineMagnet:addEventListener( "collision" )
				table.insert(enemyTable, mineMagnet)
			elseif randomNumber == 5 and createdOneElectricity == false then
				createdOneElectricity = true

				local electricity = display.newSprite( sprites.electricity.sheet , sprites.electricity.sequence )
				electricity:setSequence( "Electricity" )
				electricity:play()

				local electricitySize = .3
				electricity.xScale = electricitySize
				electricity.yScale = electricitySize
				electricity.rotation = 90

				electricity.x = tile_Horizontal.x
				electricity.y = tile_Horizontal.y

				physics.addBody( electricity, "static", { friction=0.5, bounce=0.3 } )	
				electricity.isSensor = true
				electricity.collision = onElectricityCollision
				electricity:addEventListener( "collision" )

				electricity.tile = tileHorizontal
				tile_Horizontal.containsElectricity = true
				tile_Horizontal.empty = false

				tile_Horizontal.containsItem = true
				tile_Horizontal.item = electricity
			end

		end

		if tile_Horizontal.containsElectricity then
			timerTable[#timerTable+1] = timer.performWithDelay(50, updateElectricityTiles)
		end
		--Fill rows table
		table.insert(itemTable, tile_Horizontal.item)
		table.insert(tileTable, tile_Horizontal)
		sceneGroup:insert( tile_Horizontal )
	end

	rowNumber = rowNumber + 1
	yPoint = yPoint - tileSize
end


function createTileMap(horizontalRowLength, verticalRowLength, tileSize)
	for i = 1, horizontalRowLength, 1 do

		tile_Vertical = display.newImageRect("images/game-objects/rockTile.jpg", tileSize, tileSize)

		tile_Vertical.x = (i - .5) * tileSize
		tile_Vertical.y = screenH - (tileSize)

		tile_Vertical.column = i

		tile_Vertical.row = 1
		tile_Vertical.id = tileId

		tileId = tileId + 1

		--Add touch listener to each tile
		tile_Vertical.touch = onTileTouch
		tile_Vertical:addEventListener( "touch", tile_Vertical )
		tile_Vertical.collision = onTileCollision
		tile_Vertical:addEventListener( "collision" )


		physics.addBody( tile_Vertical, "static", { friction=0.5, bounce=0.3 } )

		--Fill rows table
		table.insert(tileTable, tile_Vertical)
		blackTiles:insert( tile_Vertical )

		for b = 1, verticalRowLength, 1 do

			-- <5 = blank, 6 = black
			local tileType = math.random(0, 5)

			if b <= 4 then
				tileType = 4
			elseif b > 4 and b < 8 then
				tileType = 2
			end

			if tileType <= 3 then
				tile_Horizontal = display.newRect(tile_Vertical.x, tile_Vertical.y - (tileSize * b), tileSize, tileSize)
				tile_Horizontal:setFillColor( 0, 0, 0 )
			else
				tile_Horizontal = display.newImageRect("images/game-objects/rockTile.jpg", tileSize, tileSize)
				tile_Horizontal.x = tile_Vertical.x
				tile_Horizontal.y = tile_Vertical.y - (tileSize * b)
				blackTiles:insert( tile_Horizontal )
			end

			tile_Horizontal.column = i
			tile_Horizontal.row = b + 1
			tile_Horizontal.id = tileId

			tileId = tileId + 1

			--Insert tile to table
			tile_Horizontal.touch = onTileTouch
			tile_Horizontal:addEventListener( "touch", tile_Horizontal )

			if tileType >= 4 then
				tile_Horizontal.collision = onTileCollision
				tile_Horizontal:addEventListener( "collision" )
				physics.addBody( tile_Horizontal, "static", { friction=0.5, bounce=0.3 } )	
			else
				randomNumber = math.random(8)
				if randomNumber < 3 then
					--local star = display.newSprite( spriteSheet1, sequenceData1 )
					local star = display.newSprite( sprites.star.sheet , sprites.star.sequence )
					star:setSequence( "Star" )
					star:play()

					star.x = tile_Horizontal.x
					star.y = tile_Horizontal.y

					physics.addBody( star, "static", { friction=0.5, bounce=0.3, radius=10 } )	
					star.isSensor = true
					star.collision = onOrbCollision
					star:addEventListener( "collision" )

					tile_Horizontal.containsItem = true
					tile_Horizontal.item = star
				end

			end

			--Fill rows table
			table.insert(itemTable, tile_Horizontal.item)
			table.insert(tileTable, tile_Horizontal)
		end
	end
end
--------------------------------------------

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
	orbText.x = screenW*.26
	orbText.y = screenH*.05

	local star = display.newSprite( sprites.star.sheet , sprites.star.sequence)
	star:setSequence( "StarPic" )
	star:play()

	star.x = screenW*.05
	star.y = 20

	local starSize = .5
	star.xScale = starSize
	star.yScale = starSize


	-- create a grey rectangle as the backdrop
	local background = display.newRect( 0, 0, screenW, screenH )
	background.anchorX = 0
	background.anchorY =
	background:setFillColor( 0, 0, 0 )

	horizontalRowLength = 6
	tileSize = screenW / horizontalRowLength
	local verticalRowLength = (screenH / tileSize) + 1

	tileId = 0
	rowNumber = verticalRowLength + 2
	currentColumn = 1
	yPoint = ( screenH ) - 
			 ((verticalRowLength) * tileSize) +
			 tilePositionDeviceAdjustment

	tileTable = {}
	enemyTable = {}
	itemTable = {}
	orbTable = {}

	function radiate(self)
		transition.to( self, { time=1000, alpha=.8, 
			onComplete=function() 
				radiate2(self)
			end} )
	end

	function radiate2(self)
		transition.to( self, { time=800, alpha=1, 
			onComplete=function() 
				radiate(self)
			end} )
	end

	player = display.newImageRect("images/game-objects/player.png", tileSize, tileSize )
	player.x = screenW * .58
	player.y = screenH * .23

	player.wallCollisionCount = 0
	physics.addBody( player, "dynamic", { friction=1, bounce=0.3, radius=tileSize*.3 } )
	radiate(player)

	createTileMap(horizontalRowLength, verticalRowLength, tileSize)
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	for i = #tileTable, 1, -1 do
      	local tile = tileTable[i]
      	sceneGroup:insert( tile )
    end
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

		function gameLogic()
			if player.wallCollisionCount >= 2 then
				local options1 = 
				{
				    text = "Ouch!",
				    x = screenW * .5,
				    y = screenH * .4,
				    width = 420,     --required for multi-line and alignment
				    align = "center",
				    font = native.systemFont,
				    fontSize = 38
				}
				--gameOverText = display.newText( options1 )
				--gameOverText:setFillColor( 1, 1, 1 )
				--gameOver = true

				if player.x > screenW - (tileSize*1.5) then
					local vx, vy = player:getLinearVelocity()
					player:setLinearVelocity( -30, vy )
				elseif player.x < 0 + (tileSize*1.5) then
					local vx, vy = player:getLinearVelocity()
					player:setLinearVelocity( 30, vy )
				end
			end
		end

		Runtime:addEventListener("enterFrame", gameLogic)

		function maintainViewLayers()
			itemsGroup:toFront()
			blackTiles:toFront()
			player:toFront()
			orbText:toFront()
			player:toFront()
		end

		Runtime:addEventListener("enterFrame", maintainViewLayers)

		function moveTiles()
			for i = #tileTable, 1, -1 do
	 	      	local tile = tileTable[i]

				if tile ~= nil then
					tile.y = tile.y + gameSpeed

					if tile.y > screenH + tileSize then
						tile.consumed = true

					end

					if tile.consumed then
							
						--Call new line only once per line
						if tile.column == 1 then
							createRow(horizontalRowLength, tileSize, yPoint, sceneGroup)
						end
						-- object.remove(tileTable[i])
						display.remove( tileTable[i] )
						table.remove( tileTable, i )	    				
					end
				end
			end
		end

		Runtime:addEventListener("enterFrame", moveTiles)

		function enemyBehavior()
			for i = #enemyTable, 1, -1 do
	 	      	local enemy = enemyTable[i]

				if enemy ~= nil then
					local enemyMoveDistanceX = player.x - enemyTable[i].x
				    local enemyMoveDistanceY = player.y - enemyTable[i].y

				   	local enemySpeed = .15

				   	enemyMoveDistanceX = enemyMoveDistanceX * enemySpeed
				   	enemyMoveDistanceY = enemyMoveDistanceY * enemySpeed

				    enemy:setLinearVelocity( enemyMoveDistanceX, enemyMoveDistanceY )

				    enemy.y = enemy.y + gameSpeed

					if enemy.y > screenH + tileSize then
						enemy.consumed = true
					end

					if enemy.consumed == true then
						display.remove( enemyTable[i] )
						table.remove( enemyTable, i )	    				
					end
				end
			end
		end

		Runtime:addEventListener("enterFrame", enemyBehavior)

		function moveItems()
			for i = #itemTable, 1, -1 do
	 	      	local item = itemTable[i]

				if item ~= nil then

				    item.y = item.y + gameSpeed

					if item.y > screenH + tileSize then
						item.consumed = true
					end

					if item.consumed == true then
						display.remove( itemTable[i] )
						table.remove( itemTable, i )	    				
					end
				end
			end
		end

		Runtime:addEventListener("enterFrame", moveItems)

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