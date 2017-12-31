local GameTables = require('game.tables')

return {
  name = "electricityGenerator",
  collisionType = 'electricity',
  physics = {
    type = 'static',
    isSensor = true
  },
  tables = { 
    GameTables.tiles,
  }
}