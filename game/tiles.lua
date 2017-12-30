local Tiles = {}
local matrix = require('modules.Matrix')

Tiles.fill = function()
  local config = require('game.Config')
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
  local tables = options.tables or {}

  local tile

  if(obj.sprite) then
    tile = display.newSprite( obj.sprite.sheet , obj.sprite.sequence )
    tile:setSequence( "Main" )
    tile:play()
    local scale = obj.sprite.scale
    tile.xScale = scale
    tile.yScale = scale
    tile.rotation = obj.sprite.rotation
  
    physics.addBody( tile, "static", { friction=0.5, bounce=0.3 } )	
 
  else
    tile = display.newImageRect("images/game-objects/" .. obj.name .. ".png", tileSize, tileSize)    
  end

  tile.x = x
  tile.y = y
  tile.info = obj

  if(obj.physics) then
    physics.addBody( tile, obj.type, { friction=0.5, bounce=0 } )
    -- tile.isSensor = true
    -- tile.collision = ontileCollision
    -- tile:addEventListener( "collision" )
  end	

  for i = 1, table.getn(tables), 1 do
    table.insert(tables[i], tile)
  end

  return tile
end

Tiles.init = function(table)

  local config = require('game.config')
  local level = config.level


  local tile_Horizontal = display.newImageRect("images/game-objects/rockTile.jpg", tileSize, tileSize)
  tile_Horizontal.x = 150
  tile_Horizontal.y = 300
  physics.addBody( tile_Horizontal, "static", { friction=0.5, bounce=0 } )	
  table.insert(tileTable, tile_Horizontal)
end




return Tiles