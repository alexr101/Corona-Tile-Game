local Row = {}

function _remover(sceneGroup)
  local SceneGroup = require('Services.SceneGroup')
  local Screen = require('Device.Screen')

  SceneGroup.forEach(sceneGroup, function(obj)
    if(obj.y > Screen.height + obj.height) then
      print(obj.coordinates.column)
    end
  
  end)
end

Row.remover = function(sceneGroup)
  return function() _remover(sceneGroup) end
end


return Row