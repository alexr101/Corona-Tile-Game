local Sprites = require('sprites.sprites')  
local GameTables = require('game.tables')
local Screen = require('modules.screen')

local Config = require('game.config')
local scaleSizes = {
  [1] = 0,
  [2] = 0,
  [3] = 0,
  [4] = 0,
  [5] = .3125,
  [6] = .26,
  [7] = .225,
  [8] = .1955,
  [9] = .173,
}

return  {
  name = "electricity",
  physics = false,
  tables = {
    GameTables.tiles
  },
  physics = {
    type = 'static',
    isSensor = true
  },
  sprite = {
    sheet = Sprites.electricity.sheet,
    sequence = Sprites.electricity.sequence,
    scale = scaleSizes[Config.tiles],
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