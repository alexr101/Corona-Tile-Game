local GameTables = require('Game.Tables')

return {
  name = "UnmovableSpace",
  collisionType = 'rock',
  conductsElectricity = false,
  blocksElectricity = true,
  unmovable = true,
  enemyCollider = true,
  physics = {
    type = 'static',
    isSensor = false
  },
  tables = { 
    GameTables.tiles,
  }
}