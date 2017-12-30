local GameTables = require('game.tables')

return {
  name = "mineMagnet",
  physics = {
    type = 'static',
    isSensor = true
  },
  tables = { 
    GameTables.tiles,
    GameTables.enemies
  }
}