local GameTables = require('Game.Tables')

return {
  name = "RockCrumbling",
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