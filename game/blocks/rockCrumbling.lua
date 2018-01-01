local GameTables = require('game.tables')

return {
  name = "rockTileCrumbling",
  collisionType = 'rockCrumbling',
  conductsElectricity = false,
  physics = {
    type = 'static',
    isSensor = false
  },
  tables = { 
    GameTables.tiles,
  }
}