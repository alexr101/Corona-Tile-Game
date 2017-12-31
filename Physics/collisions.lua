local Collisions = {}
local object = require('Services.ObjectHelpers')
local gameState = require('game.State')
local Graphics = require('UI.Graphics')

Collisions.star = function( self, event )
    if ( event.phase == "began" and event.other == player ) then
      gameState.add('stars', 1)
    	self.destroy = true
    end
end

Collisions.electricity =  function( self, event )
    if ( event.phase == "began" and event.other == player ) then
    	gameOver = true
    end
end

Collisions.ground = function( self, event )
    if ( event.phase == "began" and event.other == player ) then
    	player.wallCollisionsCount = player.wallCollisionsCount + 1
    end

    if ( event.phase == "ended" and event.other == player ) then
    	if player.wallCollisionsCount > 0 then
    		player.wallCollisionsCount = player.wallCollisionsCount - 1
    	end
    end
end

Collisions.enemy = function( self, event )
    if ( event.phase == "began" and event.other == player ) then
    	self.isSensor = true
    	self.destroy = true
    	player:setLinearVelocity(0, 0)
    	Graphics.damageFlicker(player)
    end
end

Collisions.mine = function( self, event )
    if ( event.phase == "began" and event.other == player ) then
    	self.destroy = true
    end
end

return Collisions