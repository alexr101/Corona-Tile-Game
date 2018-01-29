local Enemy = {}

Enemy.movement = function(obj)
  if(obj.info.enemy) then
    obj.x = obj.x + obj.info.speed   
  end

end

return Enemy