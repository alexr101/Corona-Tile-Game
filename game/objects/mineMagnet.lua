local GameTables = require('game.tables')

return {
  name = "mineMagnet",
  physics = false,
  tables = { 
    GameTables.tiles,
    GameTables.enemies
  }
}