local GameTables = require('game.tables')

return {
  name = "debugSpace",
  collisionType = 'none',
  physics = false,
  tables = { 
    GameTables.tiles,
  }
}