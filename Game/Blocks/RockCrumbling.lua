local GameTables = require('Game.Tables')

return {
  name = "RockTileCrumbling",
  collisionType = 'rockCrumbling',
  conductsElectricity = false,
  blocksElectricity = true,
  physics = {
    type = 'static',
    isSensor = false
  },
  tables = { 
    GameTables.tiles,
  }
}