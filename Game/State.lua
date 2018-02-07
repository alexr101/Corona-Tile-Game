local State = {}
local Config = require('Game.Config')
local Screen = require('Device.screen')

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

State.setSceneGroup = function(group)
  State.sceneGroup = group
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
end

State.add = function(stat, amount)
  State[stat] = State[stat] + amount

  -- TODO: update TEXT UI
  -- orbText.text = orbs
end

State.init = function()
  State.setTileSize()
  State.setColXPosition()
end

return State


