local stats = {}

local currentGame = {
  score = 0,
  orbs = 0,
  active = false
}

stats.resetGame = function()
  currentGame.score = 0
  currentGame.orb = 0
  currentGame.active = false
end

stats.add = function(stat, amount)
  stats.currentGame[stat] = stats.currentGame [stat] + amount

  -- TODO: update TEXT UI
  -- orbText.text = orbs
end

stats.get = function(stat)
  return currentGame[stat]
end


