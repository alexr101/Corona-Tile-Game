local tiles = {}
local matrix = require('modules.matrix')

tiles.init = function(table)

  local config = require('game.config')
  local level = config.level
  local xMatrix = config.xMatrix
  local yMatrix = config.yMatrix

  



end

tiles.create = function(obj, x, y)

  local tile = display.newImageRect("images/game-objects/" .. obj.name .. ".jpg", tileSize, tileSize)
  tile.x = x
  tile.y = y
  physics.addBody( tile, obj.gravity, { friction=0.5, bounce=0 } )	
  table.insert(loadstring(obj.table), tile)

  return tileHorizontal
end




return tiles