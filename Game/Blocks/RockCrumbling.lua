local GameTables = require('Game.State').tables

return {
  name = "RockCrumbling",
  collisionType = 'rockCrumbling',
  conductsElectricity = false,
  blocksElectricity = true,
  enemyCollider = true,
  physics = {
    type = 'static',
    isSensor = false
  },
  tables = { 
    GameTables.tiles,
  }
}