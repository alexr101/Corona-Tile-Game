local Sprites = require('sprites.sprites')  
local GameTables = require('game.tables')

return  {
  name = "star",
  physics = false,
  tables = {
    GameTables.tiles
  },
  sprite = {
    sheet = Sprites.star.sheet,
    sequence = Sprites.star.sequence,
    scale = .8,
    rotation = 0
  }
}