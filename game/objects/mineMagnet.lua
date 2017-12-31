local GameTables = require('game.tables')

return {
  name = "mineMagnet",
  outOfGrid = true,
  physics = {
    type = 'static',
    isSensor = true
  },
  tables = { 
    GameTables.tiles,
    GameTables.enemies
  }
}