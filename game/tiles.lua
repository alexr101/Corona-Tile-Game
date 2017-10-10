local tiles = {}
local matrix = require('modules.matrix')

tiles.init = function(table)

  local config = require('game.config')
  local level = config.level


  local tile_Horizontal = display.newImageRect("images/game-objects/rockTile.jpg", tileSize, tileSize)
  tile_Horizontal.x = 150
  tile_Horizontal.y = 300
  physics.addBody( tile_Horizontal, "static", { friction=0.5, bounce=0 } )	
  table.insert(tileTable, tile_Horizontal)
end




return tiles