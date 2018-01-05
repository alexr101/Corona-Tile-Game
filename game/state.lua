local State = {}
local Config = require('game.config')
local Screen = require('device.screen')

State = {
  score = 100,
  stars = 0,
  active = false,
  tileSize = 0,
  sceneGroup = {},
  colXPositions = {}
}

State.get = function()
  return State.game
end


State.resetGame = function()
  currentGame.score = 0
  currentGame.stars = 0
  currentGame.active = false
end

State.setTileSize = function()
	State.tileSize = Screen.width / Config.tiles
end
State.setTileSize()

State.setColPositions = function()
  for i = 1, Config.tiles, 1 do
    local x = State.tileSize * i + (State.tileSize*.5)
    table.insert( State.colXPositions, x)
  end
end
State.setColPositions()

State.add = function(stat, amount)
  State[stat] = State[stat] + amount

  -- TODO: update TEXT UI
  -- orbText.text = orbs
end

return State


