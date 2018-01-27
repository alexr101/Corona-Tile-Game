local Player = {}
local Screen = require('Device.Screen')

Player.instance = {}

Player.new = function(tileSize)
  Player.instance = display.newImageRect("assets/game-objects/player.png", tileSize, tileSize )
	Player.instance.x = Screen.width * .58
	Player.instance.y = Screen.height * .23
	physics.addBody( Player.instance, { density = 10, friction=1, bounce=0, radius=tileSize*.3 } )

	Graphics.radiate(Player.instance, {
		alphaLow = .7,
		alphaHigh = 1,
		speedGlow = 1000,
		speedDimmer = 300,
	})
	Player.instance.isSleepingAllowed = false
	-- Player.instance.isBullet = true
	-- Graphics.damageFlicker(Player.instance)


	return Player.instance

end

return Player