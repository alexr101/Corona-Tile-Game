local Sprites = require('sprites.sprites')  
local GameTables = require('game.tables')
local Screen = require('modules.screen')

return  {
  name = "electricity",
  physics = false,
  tables = {
    GameTables.tiles
  },
  sprite = {
    sheet = Sprites.electricity.sheet,
    sequence = Sprites.electricity.sequence,
    scale = .225,
    rotation = 90
  }
}