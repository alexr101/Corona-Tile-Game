local GameTables = require('Game.State').tables

return {
  name = "Enemy1",
  collisionType = 'enemy',
  conductsElectricity = false,
  blocksElectricity = false,
  outOfGrid = true,
  speed = 2,
  enemy=true,
  enemyCollider = true,
  effects = {
    'radiate'
  },
  physics = {
    type = 'dynamic',
    isSensor = false,
    bounce = .2,
    radius = .3
  },
  tables = { 
    GameTables.tiles,
  }
}