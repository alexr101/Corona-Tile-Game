local Row = {}

function _remover(sceneGroup)
  local SceneGroup = require('Services.SceneGroup')
  local Screen = require('Device.Screen')

  SceneGroup.forEach(sceneGroup, function(obj)
    if(obj.coordinates.column == 0 and obj.y > Screen.height + obj.height) then
      -- RowBehaviors.deleteRow(obj.coordinates.row)
    end
  end)
end

Row.remover = function(sceneGroup)
  return function() _remover(sceneGroup) end
end


return Row