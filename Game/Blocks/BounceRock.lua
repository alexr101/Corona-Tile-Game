local GameTables = require('Game.State').tables

return {
  name = "BounceRock",
  collisionType = 'bounceRock',
  conductsElectricity = false,
  blocksElectricity = true,
  enemyCollider = true,
  touchEvents = {'bouncePlayer'},
  physics = {
    type = 'static',
    isSensor = false
  },
  tables = { 
    GameTables.tiles,
  }
}