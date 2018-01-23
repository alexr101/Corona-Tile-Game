local Collisions = {}
local object = require('Services.ObjectHelpers')
local gameState = require('Game.State')
local Graphics = require('UI.Graphics')
local Player = require('Game.Player')
local ObjectHelpers = require('Services.ObjectHelpers')

Collisions.star = function( self, event )
    if ( event.phase == "began" and event.other == Player.instance ) then
        ObjectHelpers.replace(self)
        gameState.add('stars', 1)
    end
end

Collisions.none = function( self, event )
end

Collisions.bounceRock = function( self, event )
    if ( event.phase == "began" and event.other == Player.instance ) then
        player.canBounce = true

    end    

    if ( event.phase == "ended" and event.other == Player.instance ) then
        player.canBounce = false
    end
end

Collisions.electricity =  function( self, event )
    if ( event.phase == "began" and event.other == Player.instance ) then
    	AppState.active = false
    end
end

Collisions.rock = function( self, event )
    if ( event.phase == "began" and event.other == Player.instance ) then

    end

    if ( event.phase == "ended" and event.other == Player.instance ) then
    end
end

Collisions.rockCrumbling = function( self, event )
    if ( event.phase == "began" and event.other == Player.instance ) then
        -- self.rockHealth = self.rockHealth - 1
    end

end

-- Collisions.enemy = function( self, event )
--     if ( event.phase == "began" and event.other == player ) then
--     	self.isSensor = true
--     	self.destroy = true
--     	player:setLinearVelocity(0, 0)
--     	Graphics.damageFlicker(player)
--     end
-- end

Collisions.mine = function( self, event )
    if ( event.phase == "began" and event.other == Player.instance ) then
        ObjectHelpers.remove(self)
        Graphics.damageFlicker(player)
    end
end

return Collisions