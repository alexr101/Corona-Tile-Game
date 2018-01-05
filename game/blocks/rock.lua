local GameTables = require('game.tables')

return {
  name = "rockTile",
  collisionType = 'rock',
  conductsElectricity = false,
  blocksElectricity = true,
  physics = {
    type = 'static',
    isSensor = false
  },
  tables = { 
    GameTables.tiles,
  }
}