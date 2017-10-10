local object = {}

-- Optional: index
-- otherwise treated as an object
object.remove = function(obj, index)
  index = index or nil

  if index ~= nil then
    display.remove( tileTable[i] )
	  table.remove( tileTable, i )
    titleTable[i] = nil
  else
    display.remove(obj)
    obj = nil
  end  	
end

object.pastLimit = function(self, direction, limit)
  if direction == 'right' then
    return self.x > limit
  elseif direction == 'left' then
    return self.x < limit
  elseif direction == 'down' then
    return self.y > limit
  elseif direction == 'up' then
    return self.y < limit
  end

  return nil
end

return object