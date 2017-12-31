local GameTables = require('game.tables')

return {
  name = "mineMagnet",
  collisionType = 'mine',
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