local Sprites = require('sprites.sprites')  
local GameTables = require('game.tables')

return  {
  name = "electricity",
  physics = false,
  tables = {
    GameTables.tiles
  },
  sprite = {
    sheet = Sprites.electricity.sheet,
    sequence = Sprites.electricity.sequence,
    scale = .25,
    rotation = 90
  }
}