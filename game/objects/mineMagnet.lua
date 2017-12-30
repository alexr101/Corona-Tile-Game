local GameTables = require('game.tables')

return {
  name = "mineMagnet",
  table = "mineMagnets",
  physics = false,
  tables = { 
    GameTables.tiles,
    GameTables.enemies
  }
}