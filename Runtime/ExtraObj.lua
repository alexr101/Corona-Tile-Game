local ExtraObj = {}

ExtraObj.remover = function(obj)
  local Screen = require('Device.Screen')
  local ObjectHelpers = require('Services.ObjectHelpers')
  local State = require('Game.State')
  local removeLimit = obj.y > Screen.height + (State.tileSize)

  if(obj.info.outOfGrid and removeLimit) then
    ObjectHelpers.remove(obj)
  end

end

return ExtraObj