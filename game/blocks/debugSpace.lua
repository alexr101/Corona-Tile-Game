local GameTables = require('game.tables')

return {
  name = "debugSpace",
  collisionType = 'none',
  conductsElectricity = true,
  physics = false,
  tables = { 
    GameTables.tiles,
  }
}