local GameTables = require('Game.State').tables

return {
  name = "ElectricityGenerator",
  collisionType = 'electricity',
  conductsElectricity = true,
  physics = {
    type = 'static',
    isSensor = false
  },
  tables = { 
    GameTables.tiles,
  }
}