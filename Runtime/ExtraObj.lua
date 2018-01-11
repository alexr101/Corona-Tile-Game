local ExtraObj = {}

ExtraObj.remover = function(obj)
  local Screen = require('Device.Screen')
  local ObjectHelpers = require('Services.ObjectHelpers')
  local State = require('Game.State')
  local removeLimit = obj.y > Screen.height + (State.tileSize)
  print(obj.info.outOfGrid)
  if(obj.info.outOfGrid and removeLimit) then
    print('remove extra obj ' .. obj.info.name)
    ObjectHelpers.remove(obj)
  end

end

return ExtraObj