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
    print(numChildren)
    for i = numChildren, 1, -1 do
      print(i);
      local obj = sceneGroup[i]
      if(obj~= nil) then
        cb(obj)
      end
    end
  end
end

return SceneGroup