local GameTables = require('Game.Tables')

return {
  name = "Rock",
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