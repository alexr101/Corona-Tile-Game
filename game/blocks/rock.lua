local GameTables = require('game.tables')

return {
  name = "rockTile",
  physics = {
    type = 'static',
    isSensor = false
  },
  tables = { 
    GameTables.tiles,
  }
}