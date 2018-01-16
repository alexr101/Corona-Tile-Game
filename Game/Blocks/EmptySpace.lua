local GameTables = require('Game.Tables')

return {
  name = "EmptySpace",
  collisionType = 'none',
  conductsElectricity = true,
  physics = false,
  tables = { 
    GameTables.tiles,
  }
}