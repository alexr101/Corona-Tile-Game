local State = {}

State = {
  score = 100,
  starts = 0,
  active = false,
  tileSize = 0,
  sceneGroup = {}
}

State.get = function()
  return State.game
end


print('called state')

State.resetGame = function()
  currentGame.score = 0
  currentGame.stars = 0
  currentGame.active = false
end

State.add = function(stat, amount)
  State[stat] = State[stat] + amount

  -- TODO: update TEXT UI
  -- orbText.text = orbs
end

return State


