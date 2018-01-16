local Tiles = {}
local matrix = require('Game.Map.Matrix')
local Swipe = require('Device.Swipe')
local Collisions = require('Physics.Collisions')
local Node = require('Game.Map.Node')

Tiles.fill = function()
  local config = require('Game.Config')
  local xMatrix = config.xMatrix
  local yMatrix = config.yMatrix

  local grid = matrix.create()

  for i = 1, xMatrix do
    for j = 1, yMatrix do
      grid[i][j] = 's'
    end
  end
end


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
  
  if(obj.physics) then
    physics.addBody( tile, obj.physics.type, { friction=0.5, bounce=0 } )
    tile.isSensor = obj.physics.isSensor
    
    tile.collision = Collisions[obj.collisionType]
    tile:addEventListener( "collision" )
  end	

  for i = 1, table.getn(tables), 1 do
    table.insert(tables[i], tile)
  end

  return tile
end

Tiles.replace = function(options)
  local AppState = require('Game.State')
  local Grid = require('Game.Map.Grid')

  local oldObj = options.oldObj
  local newObjInfo = options.newObjInfo
  local x = options.x
  local y = options.y
  local row = options.row
  local column = options.column

  Grid.matrix[row][column]:removeSelf()
  Grid.matrix[row][column] = nil
  
  Grid.matrix[row][column] = Tiles.create(newObjInfo, {
      x = x, 
      y = y, 
      tileSize = AppState.tileSize, 
  })

  Grid.matrix[row][column].coordinates = {
    row = row,
    column = column
  } 
  
  Node.updatePositions({ 
    row = row, 
    column = column,
    directions = {'all'}
  })

  AppState.sceneGroup:insert(Grid.matrix[row][column])
end

Tiles.init = function(table)

  local config = require('Game.Config')
  local level = config.level

  local tile_Horizontal = display.newImageRect("assets/game-objects/rockTile.jpg", tileSize, tileSize)
  tile_Horizontal.x = 150
  tile_Horizontal.y = 300
  physics.addBody( tile_Horizontal, "static", { friction=0.5, bounce=0 } )	
  table.insert(tileTable, tile_Horizontal)
end




return Tiles