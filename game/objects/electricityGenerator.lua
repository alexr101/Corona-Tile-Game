local GameTables = require('game.tables')

return {
  name = "electricityGenerator",
  physics = {
    type = 'static',
    isSensor = true
  },
  tables = { 
    GameTables.tiles,
  }
}