local gameCollision = {}
local collision = require('modules.collision')
local object = require('modules.object')
local gameStats = require('game.stats')

gameCollision.orb = function( self, event )
  collision.between()
    if ( event.phase == "began" and event.other == player ) then
      gameStats.add('orb', 1)
    	self.consumed = true
      -- object.remove(self)
    end
end

function onElectricityCollision( self, event )
    if ( event.phase == "began" and event.other == player ) then
    	gameOver = true
    end
end

function onTileCollision( self, event )
    if ( event.phase == "began" and event.other == player ) then
    	player.wallCollisionCount = player.wallCollisionCount + 1
    end

    if ( event.phase == "ended" and event.other == player ) then
    	if player.wallCollisionCount > 0 then
    		player.wallCollisionCount = player.wallCollisionCount - 1
    	end
    end
end

function onEnemyCollision( self, event )
    if ( event.phase == "began" and event.other == player ) then
    	self.isSensor = true
    	self.consumed = true
    	player:setLinearVelocity(0, 0)

    	transition.to( player, { time=300, alpha=.3, 
			onComplete=function() 
				player.alpha = 1
			end
			} )
    end
end

function onMineCollision( self, event )
    if ( event.phase == "began" and event.other == player ) then
    	self.consumed = true
    end
end