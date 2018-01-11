local ObjectHelpers = {}

-- Optional: index
-- otherwise treated as an object
ObjectHelpers.replace = function(obj, index)
  local Grid = require('Game.Map.Grid')
  local Tiles = require('Game.Map.Tiles')
  local ObjectGenerator = require('Services.ObjectGenerator')
  local AppState = require('Game.State')

  index = index or nil

  if index ~= nil then
    -- display.remove( tileTable[i] )
	  -- table.remove( tileTable, i )
    -- titleTable[i] = nil
  else
    -- get metadata
    local row
    local column
    local objInfo

    -- TODO: why would coordinates be nil???
    -- out of grid objects :-)
    if(obj.coordinates ~= nil) then
      row = obj.coordinates.row
      column = obj.coordinates.column
      objInfo = Grid.matrix[row][column].info


      -- get close proximity objects for transition position references
      local objForVerticalReference
      local objForHorizontalReference

      if (Grid.matrix[row+1] ~= nil) then
        objForHorizontalReference = Grid.matrix[row+1][column]
      else
        objForHorizontalReference = Grid.matrix[row-1][column]
      end

      if (column > 0) then
          objForVerticalReference = Grid.matrix[row][column-1]
      else
          objForVerticalReference = Grid.matrix[row][column+1]
      end

      -- Set x and y positions
      local x = obj.x
      local y = obj.y

      if (obj.moving == 'horizontally') then
        x = objForHorizontalReference.x
      else
        y = objForVerticalReference.y
      end

      if(objInfo.consumable) then
        local replaceTileFn = Tiles.replace({
          oldObj = obj,
          newObjInfo = ObjectGenerator.EmptySpace,
          x = x,
          y = y,
          row = row,
          column = column
        })

        timer.performWithDelay( 1, replaceTileFn )
      end
    end
  end
end

ObjectHelpers.remove = function(obj)

  if( obj.removeSelf ~= nil ) then
    obj:removeSelf()
    obj = nil
  end
end

ObjectHelpers.pastLimit = function(self, direction, limit)
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

return ObjectHelpers