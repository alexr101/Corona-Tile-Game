local Row = {}

Row.remover = function(obj)
  local Screen = require('Device.Screen')
  local removeLimit = obj.y > Screen.height + obj.height

  if(obj.coordinates ~= nil and obj.coordinates.column == 0 and removeLimit) then
    print('remove row')
    -- RowBehaviors.deleteRow(obj.coordinates.row)
  end
end

return Row