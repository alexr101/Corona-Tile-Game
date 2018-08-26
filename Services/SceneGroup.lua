-----------------------------------------------------------------------------------------
--
-- SceneGroup Helper Functions
--
-----------------------------------------------------------------------------------------


local SceneGroup = {}

SceneGroup.forEach = function(sceneGroup, cb)
  if(sceneGroup ~= nil) then
    local numChildren = #sceneGroup;
    if(#sceneGroup == 0) then numChildren = sceneGroup.numChildren end

    if(numChildren == 0 or numChildren == nil) then return end
    for i = numChildren, 1, -1 do
      local obj = sceneGroup[i]
      if(obj~= nil) then
        cb(obj)
      end
    end
  end
end

return SceneGroup