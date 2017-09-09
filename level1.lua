local composer = require( "composer" )
local scene = composer.newScene()
composer.removeScene( "menu" )

local physics = require "physics"
physics.start(true)
physics.setDrawMode( "normal" )

local sprites = require('sprites.sprites');
local math = require('modules.math')

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



function switchPositions(direction, object1, object2)

	column1 = object1.column
	row1 = object1.row
	id1 = object1.id

	column2 = object2.column
	row2 = object2.row
	id2 = object2.id

	local extraTile1 = 0
	local extraTile2 = 0
	nextColumn = 1
	if object1.column == horizontalRowLength and direction == "vertical" then
		nextColumn = -1
	end
	if direction == "vertical" then
		for i = #tileTable, 1, -1 do
	  		local tile = tileTable[i]

  			if tile ~= nil then
		  		if object1.row == tile.row and object1.column + nextColumn == tile.column then
		  			extraTile1 = tile
		  		end
		  		if object2.row == tile.row and object2.column + nextColumn == tile.column then
		  			extraTile2 = tile
		  		end
		  	end
		end
	end

	if direction == "horizontal" then
		transition.to( object1, { time=100, x=object2.x, 
			onComplete=function() 
				object1.column = column2
				object1.id = id2

				if object1.containsItem == true then
					object1.item.x = object1.x
				end

			end} )
		transition.to( object2, { time=100, x=object1.x, 
			onComplete=function() 
				object2.column = column1
				object2.id = id1

				if object2.containsItem == true then
					object2.item.x = object2.x
				end

			end} )
	end

	if direction == "vertical" then
		transition.to( object1, { time=100, y=object2.y, 
			onComplete=function() 
				object1.row = row2
				object1.id = id2
				if extraTile2 ~= nil then
					object1.y = extraTile2.y
				end

				if object1.containsItem == true then
					object1.item.y = object1.y
				end
			end} )
		transition.to( object2, { time=100, y=object1.y, 
			onComplete=function() 
				object2.row = row1
				object2.id = id1
				if extraTile1 ~= nil then
					object2.y = extraTile1.y
				end

				if object2.containsItem == true then
					object2.item.y = object2.y
				end
			end} )
	end	
end

function findSwapTile(swipeDirection, touchedTile)

	local function horizontalFind()
		for i = #tileTable, 1, -1 do
      		local tile = tileTable[i]
			if tile ~= nil then
	      		if tile.row == touchedTile.row then
					if tile.column == touchedTile.column + comparisonValue then
						if swipeDirection == "right" then
							switchPositions("horizontal", touchedTile, tile )
						else
							switchPositions("horizontal", tile, touchedTile )
						end
						
					end
	      		end
	      	end
		end
	end

	local function verticalFind()
		for i = #tileTable, 1, -1 do
      		local tile = tileTable[i]
			if tile ~= nil then
	      		if tile.column == touchedTile.column then
					if tile.row == touchedTile.row + comparisonValue then
						if swipeDirection == "up" then
							switchPositions("vertical", touchedTile, tile)
						else
							switchPositions("vertical", tile, touchedTile)
						end
						
					end
	      		end
	      	end
		end
	end

	comparisonValue = 1

	if swipeDirection == "right" then
		horizontalFind()
	elseif swipeDirection == "up" then
		verticalFind()
	else
		comparisonValue = -1

		if swipeDirection == "left" then
			horizontalFind()
		elseif swipeDirection == "down" then
			verticalFind()
		end
	end
end

function updateElectricityTiles()
	for i = #tileTable, 1, -1 do
      	local tile = tileTable[i]

		if tile.containsElectricity then

			local tileIndex = table.indexOf( tileTable, tile )
			local mainRow = tile.row
			local mainColumn = tile.column

			local rightIndexLimit = tileIndex + 
									( horizontalRowLength - (tileIndex%horizontalRowLength) )

			print(tileIndex .. " / " .. rightIndexLimit)

			local tempTileTable = {}

			--Find all empty tiles in the row
			for i =  1, #tileTable, 1 do
  				local innerTile = tileTable[i]

  				if innerTile ~= nil then
	  				if innerTile.row == mainRow then 
	  					table.insert(tempTileTable, innerTile)
	  					--tempTileTable[innerTile.column] = innerTile
	  					--You only need to catch one row so...
	  				end
	  			end

  				if #tempTileTable == horizontalRowLength then
  					break
  				end
  			end

  			for i = #tempTileTable, 1, -1 do
  				local innerTile = tempTileTable[i]
  				if innerTile.containsElectricity then
  					print("Contains Electricity: " .. innerTile.column)
  					print("mainColumn: ".. mainColumn)
  				end
  				
  			end

  			--Decide which empty tiles to the right
  				local blockedElectricity = false
	  			for i = tileIndex, rightIndexLimit, 1 do
	  				local innerTile = tileTable[i]
	  					
	  					if innerTile.row == mainRow then


			  				--called when electricity current is blocked by anything
			  				if innerTile.empty and blockedElectricity == false then

			  					local secondaryElectricity = display.newSprite( sprites.electricity.sheet , sprites.electricity.sequence )
								secondaryElectricity:setSequence( "Electricity" )
								secondaryElectricity:play()

								local electricitySize = .3
								secondaryElectricity.xScale = electricitySize
								secondaryElectricity.yScale = electricitySize
								secondaryElectricity.rotation = 0

								secondaryElectricity.x = innerTile.x
								secondaryElectricity.y = innerTile.y

								physics.addBody( secondaryElectricity, "static", { friction=0.5, bounce=0.3 } )	
								secondaryElectricity.isSensor = true
								secondaryElectricity.collision = onElectricityCollision
								secondaryElectricity:addEventListener( "collision" )

								innerTile.containsSecondaryElectricity = true
								innerTile.empty = false

								innerTile.containsItem = true
								innerTile.item = secondaryElectricity
								table.insert(itemTable, innerTile.item)

			  				elseif tile.containsSecondaryElectricity then
			  					if innerTile.item ~= nil then
			  						innerTile.empty = true
			  						innerTile.containsSecondaryElectricity = false
									tileTable[i].item.consumed = true
								end
								--blockedElectricity = true
			  				else
			  					if tile.empty ~= true then
									--blockedElectricity = true
								end
			  				end

		  			end

	  			end
		end
	end
end

function onTileTouch(self, event)

	if ( event.phase == "began" ) then
        -- Set touch focus
        display.getCurrentStage():setFocus( self )
        self.isFocus = true

        --print("column: " .. self.column .. "row: " .. self.row)
    end

    if (event.phase == "ended") then

    	yEnd = event.y
    	xEnd = event.x

    	if xEnd > event.xStart + tileSize then
    		findSwapTile("right", self)
    	elseif xEnd < event.xStart - tileSize then
    		findSwapTile("left", self)
    	elseif yEnd > event.yStart + tileSize then
    		findSwapTile("down", self)
    	elseif yEnd < event.yStart - tileSize then
    		findSwapTile("up", self)
    	end

    	-- Reset touch focus
        display.getCurrentStage():setFocus( nil )
        self.isFocus = nil

        timerTable[#timerTable+1] = timer.performWithDelay(300, updateElectricityTiles)

    end
end

function onOrbCollision( self, event )
    if ( event.phase == "began" and event.other == player ) then
    	orbs = orbs + 1
    	orbText.text = orbs
    	self.consumed = true
    end
end

function onElectricityCollision( self, event )
    if ( event.phase == "began" and event.other == player ) then
    	gameOver = true
    end
end

function onTileCollision( self, event )
    if ( event.phase == "began" and event.other == player ) then
    	player.wallCollisionCount = player.wallCollisionCount + 1
    end

    if ( event.phase == "ended" and event.other == player ) then
    	if player.wallCollisionCount > 0 then
    		player.wallCollisionCount = player.wallCollisionCount - 1
    	end
    end
end

function onEnemyCollision( self, event )
    if ( event.phase == "began" and event.other == player ) then
    	self.isSensor = true
    	self.consumed = true
    	player:setLinearVelocity(0, 0)

    	transition.to( player, { time=300, alpha=.3, 
			onComplete=function() 
				player.alpha = 1
			end
			} )
    end
end

function onMineCollision( self, event )
    if ( event.phase == "began" and event.other == player ) then
    	self.consumed = true
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
	background.anchorY = 0
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