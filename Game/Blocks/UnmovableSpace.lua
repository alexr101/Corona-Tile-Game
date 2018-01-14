local GameTables = require('Game.Tables')

return {
  name = "UnmovableSpace",
  collisionType = 'rock',
  conductsElectricity = false,
  blocksElectricity = true,
  unmovable = true,
  physics = {
    type = 'static',
    isSensor = false
  },
  tables = { 
    GameTables.tiles,
  }
}