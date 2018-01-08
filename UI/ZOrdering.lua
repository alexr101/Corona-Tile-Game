local zOrdering = {}

function _order(arr)
  -- Loop through arr and order items

  itemsGroup:toFront()
  blackTiles:toFront()
  player:toFront()
  -- orbText:toFront()
  player:toFront()
end

zOrdering.order = function(arr)
  local orderFn = function() _order(arr) end
  Runtime:addEventListener("enterFrame", orderFn)
end


return zOrdering