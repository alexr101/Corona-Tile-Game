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

Collisions.enemy = function( self, event )
    if ( event.phase == "began" and event.other == Player.instance ) then
        if(Player.instance.flickering == false) then
            Graphics.damageFlicker(Player.instance)
        end
    end


    -- collide w block
    --[[

    scenario 1
        edge of block - you collide with same block while you fall

    on event.began 

        set coordinates of touchedblock

    on next event.began

        if coordinates ~= previousCoordinates then
            reverse
        end




    ]]--



    if ( event.phase == "began" and event.other ~= Player.instance and event.other.info and event.other.info.enemyCollider ) then
        print('event began')

        if(event.other.coordinates) then

            print('collided w tile in y ' .. event.other.y)

            local isWall = event.other.isWall
            local higherCollision = event.target.touchingRow and event.other.y and event.target.lastCollisionY < event.other.y
            local collidingWithSameObj = event.target.lastCollisionY == event.other.y and event.target.lastCollisionX == event.other.x
            
            print(event.target.turningAroundOnSameObj)

            if collidingWithSameObj and event.target.turningAroundOnSameObj == false then
                print('same obj so youre on edge. turn around')
                event.target.turningAroundOnSameObj = true
                event.target.info.speed = event.target.info.speed * -1
                event.target:applyLinearImpulse( 0, -100, event.target.x, event.target.y )
            elseif higherCollision then
                event.target.turningAroundOnSameObj = false
                event.target.info.speed = event.target.info.speed * -1
                event.target:applyLinearImpulse( event.target.info.speed * -200, -200, event.target.x, event.target.y )
            end

            
            
            event.target.lastCollisionY = event.other.y
            event.target.lastCollisionX = event.other.x

        end
    end

    if ( event.phase == "began" and event.other.isWall) then
        event.target.turningAroundOnSameObj = false
        event.target.info.speed = event.target.info.speed * -1
    end

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