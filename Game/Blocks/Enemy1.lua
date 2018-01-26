local GameTables = require('Game.Tables')

return {
  name = "Enemy1",
  collisionType = 'enemy',
  conductsElectricity = false,
  blocksElectricity = false,
  outOfGrid = true,
  speed = 1,
  enemy=true,
  effects = {
    'glow'
  },
  physics = {
    type = 'dynamic',
    isSensor = false,
    radius = .3
  },
  tables = { 
    GameTables.tiles,
  }
}