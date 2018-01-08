local SceneGroup = {}

SceneGroup.forEach = function(sceneGroup, cb)

	local numChildren = #sceneGroup;
	if(#sceneGroup == 0) then numChildren = sceneGroup.numChildren end

	for i = numChildren, 1, -1 do
    local obj = sceneGroup[i]
    if(obj~= nil) then
      cb(obj)
    end
	end
end

return SceneGroup