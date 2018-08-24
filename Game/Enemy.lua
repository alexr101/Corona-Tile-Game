



-- TODO: Move to Runtime

local enemy = {}

enemy.behavior = function()
  for i = #enemyTable, 1, -1 do
        local enemy = enemyTable[i]

    if enemy ~= nil then
      local enemyMoveDistanceX = player.x - enemyTable[i].x
        local enemyMoveDistanceY = player.y - enemyTable[i].y

        local enemySpeed = .15

        enemyMoveDistanceX = enemyMoveDistanceX * enemySpeed
        enemyMoveDistanceY = enemyMoveDistanceY * enemySpeed

        enemy:setLinearVelocity( enemyMoveDistanceX, enemyMoveDistanceY )

        enemy.y = enemy.y + gameSpeed

      if enemy.y > screen.height + tileSize then
        enemy.consumed = true
      end

      if enemy.consumed == true then
        display.remove( enemyTable[i] )
        table.remove( enemyTable, i )	    				
      end
    end
  end
end

Runtime:addEventListener("enterFrame", enemyBehavior)


return enemy