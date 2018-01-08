local GameTables = require('Game.Tables')

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