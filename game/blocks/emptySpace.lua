local GameTables = require('game.tables')

return {
  name = "emptySpace",
  collisionType = 'none',
  conductsElectricity = true,
  physics = false,
  tables = { 
    GameTables.tiles,
  }
}