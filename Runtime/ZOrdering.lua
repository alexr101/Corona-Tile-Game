local zOrdering = {}
local Util = require('Utils.Main');

-- Loop through arr of groups and order items based on their position in the arr. 
-- ie groupsArr = {[1]=group1, [2]=group2}
zOrdering.order = function(groupsArr)
  for k, group in Util.sorterIter(groupsArr) do
    print(group)
    group:toFront()
  end
end

return zOrdering