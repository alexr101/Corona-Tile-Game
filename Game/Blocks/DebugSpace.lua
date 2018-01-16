local GameTables = require('Game.Tables')

return {
  name = "DebugSpace",
  collisionType = 'none',
  conductsElectricity = true,
  physics = false,
  tables = { 
    GameTables.tiles,
  }
}