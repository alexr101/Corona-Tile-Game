local GameTables = require('game.tables')

return {
  name = "rockTileCrumbling",
  physics = {
    type = 'static',
    isSensor = false
  },
  tables = { 
    GameTables.tiles,
  }
}