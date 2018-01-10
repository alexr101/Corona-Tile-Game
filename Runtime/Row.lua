local Row = {}

Row.remover = function(obj)
  local Screen = require('Device.Screen')
  local RowBehaviors = require('Game.Behaviors.Row')
  local removeLimit = obj.y > Screen.height - obj.height

  if(obj.coordinates ~= nil and obj.coordinates.column == 0 and removeLimit) then
    print('remove row')
    RowBehaviors.delete(obj.coordinates.row)
  end
end

return Row