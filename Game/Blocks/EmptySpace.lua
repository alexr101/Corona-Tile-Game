local GameTables = require('Game.State').tables

return {
  name = "EmptySpace",
  collisionType = 'none',
  conductsElectricity = true,
  physics = false,
  tables = { 
    GameTables.tiles,
  }
}