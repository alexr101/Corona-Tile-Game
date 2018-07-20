local GameTables = require('Game.State').tables

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