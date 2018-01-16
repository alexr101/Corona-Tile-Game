local GameTables = require('Game.Tables')

return {
  name = "MineMagnet",
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