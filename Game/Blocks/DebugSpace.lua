local GameTables = require('Game.Tables')

return {
  name = "debugSpace",
  collisionType = 'none',
  conductsElectricity = true,
  physics = false,
  tables = { 
    GameTables.tiles,
  }
}