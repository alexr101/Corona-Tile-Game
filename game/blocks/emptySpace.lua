local GameTables = require('game.tables')

return {
  name = "emptySpace",
  collisionType = 'none',
  physics = false,
  tables = { 
    GameTables.tiles,
  }
}