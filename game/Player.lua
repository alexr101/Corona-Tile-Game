local Player = {}
local Screen = require('device.Screen')
local Graphics = require('UI.Graphics')

Player.instance = {}

Player.new = function(tileSize)
    Player.instance = display.newImageRect("assets/game-objects/player.png", tileSize, tileSize )
	Player.instance.x = Screen.width * .58
	Player.instance.y = Screen.height * .23
	physics.addBody( Player.instance, "dynamic", { friction=1, bounce=0.3, radius=tileSize*.3 } )
	Graphics.radiate(player, {
		alphaLow = .7,
		alphaHigh = 1,
		speedGlow = 1000,
		speedDimmer = 500,
    })
    return Player.instance
end


return Player