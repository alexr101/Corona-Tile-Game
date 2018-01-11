local Row = {}

Row.remover = function(obj)
  local Screen = require('Device.Screen')
  local RowBehaviors = require('Game.Behaviors.Row')
  local State = require('Game.State')
  local removeLimit = obj.y > Screen.height + (State.tileSize)

  if(obj.coordinates ~= nil and obj.coordinates.column == 0 and removeLimit) then
    print('remove row ' .. obj.coordinates.row)
    RowBehaviors.delete(obj.coordinates.row)
    RowBehaviors.newRow()
  end

end

return Row