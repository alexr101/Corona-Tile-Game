local Collisions = {}
local object = require('Services.ObjectHelpers')
local gameState = require('game.State')
local Graphics = require('UI.Graphics')
local Player = require('game.Player')
local ObjectHelpers = require('services.objectHelpers')

Collisions.star = function( self, event )
    if ( event.phase == "began" and event.other == Player.instance ) then
        ObjectHelpers.remove(self)
        gameState.add('stars', 1)
    end
end

Collisions.none = function( self, event )
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