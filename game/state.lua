local State = {}

State.currentGame = {
  score = 0,
  stars = 0,
  active = false
}

State.resetGame = function()
  currentGame.score = 0
  currentGame.stars = 0
  currentGame.active = false
end

State.add = function(stat, amount)
  State.currentGame[stat] = State.currentGame[stat] + amount

  -- TODO: update TEXT UI
  -- orbText.text = orbs
end

return State


