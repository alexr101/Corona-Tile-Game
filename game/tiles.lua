local tiles = {}
local matrix = require('modules.matrix')

tiles.fill = function()
  local config = require('game.config')
  local xMatrix = config.xMatrix
  local yMatrix = config.yMatrix

  local grid = matrix.create()

  for i = 1, xMatrix do
    for j = 1, yMatrix do
      grid[i][j] = 
    end
  end

end


tiles.create = function(obj, x, y)

  if(obj.animation) then
    -- load sprite
  else
    tile = display.newImageRect("images/game-objects/" .. obj.name .. ".jpg", tileSize, tileSize)    
  end

  tile.x = x
  tile.y = y

  if(obj.physics) then
    physics.addBody( tile, obj.type, { friction=0.5, bounce=0 } )
  end	

  table.insert(loadstring(obj.table), tile)

  return tileHorizontal
end




return tiles