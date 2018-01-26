local Player = {}
local Screen = require('Device.Screen')
local Graphics = require('UI.Graphics')

Player.instance = {}

Player.new = function(tileSize)
    Player.instance = display.newImageRect("assets/game-objects/player.png", tileSize, tileSize )
	Player.instance.x = Screen.width * .58
	Player.instance.y = Screen.height * .23
	physics.addBody( Player.instance, { density = 0, friction=0, bounce=0, radius=tileSize*.3 } )
	Graphics.radiate(player,{
		alphaLow = .7,
		alphaHigh = 1,
		speedGlow = 1000,
		speedDimmer = 500,
	})
	Player.instance.isSleepingAllowed = false
	-- Player.instance.isBullet = true



	return Player.instance

end

return Player