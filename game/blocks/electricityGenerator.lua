local GameTables = require('game.tables')

return {
  name = "electricityGenerator",
  collisionType = 'electricity',
  conductsElectricity = true,
  physics = {
    type = 'static',
    isSensor = true
  },
  tables = { 
    GameTables.tiles,
  }
}