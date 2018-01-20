local GameTables = require('Game.Tables')

return {
  name = "BounceRock",
  collisionType = 'bounceRock',
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