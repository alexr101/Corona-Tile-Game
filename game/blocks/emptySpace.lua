local GameTables = require('Game.Tables')

return {
  name = "emptySpace",
  collisionType = 'none',
  conductsElectricity = true,
  physics = false,
  tables = { 
    GameTables.tiles,
  }
}