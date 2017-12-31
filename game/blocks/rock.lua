local GameTables = require('game.tables')

return {
  name = "rockTile",
  collisionType = 'rock',
  physics = {
    type = 'static',
    isSensor = false
  },
  tables = { 
    GameTables.tiles,
  }
}