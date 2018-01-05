local State = {}
local Config = require('game.config')
local Screen = require('device.screen')

State = {
  score = 100,
  stars = 0,
  active = false,
  tileSize = 0,
  sceneGroup = {},
}

State.get = function()
  return State.game
end


State.resetGame = function()
  currentGame.score = 0
  currentGame.stars = 0
  currentGame.active = false
end

local colXPosition = {}

State.getColXPosition = function(i)
  return colXPosition[i + 1]
end

State.setTileSize = function()
	State.tileSize = Screen.width / Config.tiles
end

State.setColXPosition = function()
  for i = 0, Config.tiles, 1 do
    local x = (State.tileSize * i) + (State.tileSize*.5)
    table.insert( colXPosition, x)
  end

  print( colXPosition[0] )
end

State.add = function(stat, amount)
  State[stat] = State[stat] + amount

  -- TODO: update TEXT UI
  -- orbText.text = orbs
end

State.setup = function()
  State.setTileSize()
  State.setColXPosition()
end
State.setup()

return State


