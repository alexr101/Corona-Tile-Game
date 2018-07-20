-----------------------------------------------------------------------------------------
--
-- Handle Objects that are out of the Grid Flow (ie not part of any row or free floating)
--
-----------------------------------------------------------------------------------------


local FreeFloatingObj = {}

FreeFloatingObj.remover = function(obj)
  local Screen = require('Device.Screen')
  local ObjectService = require('Services.ObjectService')
  local State = require('Game.State')
  local removeLimit = obj.y > Screen.height + (State.tileSize)

  if(obj.info.outOfGrid and removeLimit) then
    ObjectService.remove(obj)
  end

end

return FreeFloatingObj