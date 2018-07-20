local GameTables = require('Game.State').tables

return {
  name = "DebugSpace",
  collisionType = 'none',
  conductsElectricity = true,
  physics = false,
  tables = { 
    GameTables.tiles,
  }
}