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
    scale = .3125,
    rotation = 90
  }
}

-- will need different scaling for ipads


-- 9
-- .173
-- iPad 

-- 8 
-- .1955
-- iPad 

-- 7 
-- .225
-- iPad 

-- 6
-- .26
-- iPad 

-- 5
-- .3125
-- iPad 