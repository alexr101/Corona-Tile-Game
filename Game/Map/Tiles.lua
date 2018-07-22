-----------------------------------------------------------------------------------------
--
-- Tile handles creating Corona objects, w events, and info.
--
-----------------------------------------------------------------------------------------

local Tiles = {}
local Swipe = require('Device.Swipe')
local Collisions = require('Physics.CollisionHandlers')
local Node = require('Game.Map.Node')

-- Very important function
-- Takes all parameters and create a new Corona Object w events, physics, etc
-- Adds tile.info with all game-specific properties. 
local tileSize = AppState.tileSize
Tiles.create = function(obj, options)
  local x = options.x or 0
  local y = options.y or 0
  local tileSize = options.tileSize or 0
  local tables = obj.tables or {}
  local tile

  if(obj.sprite) then
    tile = display.newSprite( obj.sprite.sheet , obj.sprite.sequence )
    tile:setSequence( "Main" )
    tile:play()
    tile.xScale = obj.sprite.scale
    tile.yScale = obj.sprite.scale
    tile.rotation = obj.sprite.rotation
  else
    tile = display.newImageRect("assets/game-objects/" .. obj.name .. ".png", tileSize, tileSize) 
  end
  
  tile.width = tileSize
  tile.height = tileSize
  tile.x = x
  tile.y = y
  tile.info = obj
  
  if(obj.outOfGrid == nil or obj.outOfGrid == false) then
    tile:addEventListener( "touch", Swipe.handler )
  end

  if(obj.effects) then
    for i = 1, table.getn(obj.effects), 1 do
      Graphics[obj.effects[i]](tile, {})
    end
  end

  if(obj.touchEvents) then

    -- TODO: move every single object through a loop...
    local function touchListener( event )
      if(event.phase == "began") then
        if(player.canBounce) then
          player:setLinearVelocity( 0, 0 )
          player:applyLinearImpulse( 0, -100, player.x, player.y )
        end
      end
    
    end
    
    tile:addEventListener( "touch", touchListener ) 
  end
  
  if(obj.physics) then
    local radius = obj.physics.radius or nil
    local bounce = obj.physics.bounce or 0
    if(radius) then
        radius = tileSize * radius
    end
    physics.addBody( tile, obj.physics.type, { 
      friction=10000, 
      bounce=bounce, 
      density=100,
      radius = radius
    } )
    tile.isSensor = obj.physics.isSensor
    tile.collision = Collisions[obj.collisionType]
    tile:addEventListener( "collision" )
  end	

  for i = 1, table.getn(tables), 1 do
    table.insert(tables[i], tile)
  end

  return tile
end

-- Take an existing tile and replace it with a new game obj. 
Tiles.replace = function(options)
  local AppState = require('Game.State')
  local Grid = require('Game.Map.Grid')

  -- Gather all data
  local newObjInfo = options.newObjInfo
  local x = options.x
  local y = options.y
  local row = options.row
  local column = options.column

  -- remove old obj
  Grid.matrix[row][column]:removeSelf()
  Grid.matrix[row][column] = nil

  -- create new obj & add it to Grid
  Grid.matrix[row][column] = Tiles.create(newObjInfo, {
      x = x, 
      y = y, 
      tileSize = AppState.tileSize, 
  })
  Grid.matrix[row][column].coordinates = {
    row = row,
    column = column
  } 
  Grid.matrix[row][column].node = Node.new()
  Grid.updateNodeConnections({ 
    row = row, 
    column = column
  })

  AppState.sceneGroup:insert(Grid.matrix[row][column])
end

return Tiles