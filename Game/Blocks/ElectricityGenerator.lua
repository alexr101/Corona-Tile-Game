local GameTables = require('Game.Tables')

return {
  name = "ElectricityGenerator",
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