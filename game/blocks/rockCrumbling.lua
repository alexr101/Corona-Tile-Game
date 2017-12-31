local GameTables = require('game.tables')

return {
  name = "rockTileCrumbling",
  collisionType = 'rockCrumbling',
  physics = {
    type = 'static',
    isSensor = false
  },
  tables = { 
    GameTables.tiles,
  }
}