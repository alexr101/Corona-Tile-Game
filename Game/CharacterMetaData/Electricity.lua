local Sprites = require('Sprites.Main')  
local GameTables = require('Game.State').tables
local Screen = require('Device.Screen')

local Config = require('Game.config')
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
  name = "Electricity",
  collisionType = 'electricity',
  physics = false,
  conductsElectricity = true,
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