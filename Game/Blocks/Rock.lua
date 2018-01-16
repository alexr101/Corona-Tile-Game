local GameTables = require('Game.Tables')

return {
  name = "RockTile",
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