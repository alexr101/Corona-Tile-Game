-----------------------------------------------------------------------------------------
--
-- Handle Enemy Movement
--
-----------------------------------------------------------------------------------------

local Enemy = {}

-- Move an enemy according to its current speed
Enemy.movement = function(obj)
  if(obj.info.enemy) then
    obj.x = obj.x + obj.info.speed   
  end

end

return Enemy