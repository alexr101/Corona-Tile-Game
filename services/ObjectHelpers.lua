local ObjectHelpers = {}

-- Optional: index
-- otherwise treated as an object
ObjectHelpers.remove = function(obj, index)
  local Grid = require('game.map.Grid')
  local Tiles = require('game.map.tiles')

  index = index or nil

  if index ~= nil then
    display.remove( tileTable[i] )
	  table.remove( tileTable, i )
    titleTable[i] = nil
  else
    local row = obj.coordinates.row
    local column = obj.coordinates.column
    local obj = Grid.matrix[row][column]
    local objInfo = Grid.matrix[row][column].info
    local x = obj.x
    local y = obj.y

    obj:removeSelf()
    obj = nil
    local function replaceGrid() 
      Grid.matrix[row][column] = Tiles.create(objInfo, {
          x = x, 
          y = y, 
          tileSize = AppState.tileSize, 
      })

      Grid.matrix[row][column].coordinates ={
        row = row,
        column = column
      } 
    end

    timer.performWithDelay( 1, replaceGrid )

    
    -- display.remove(obj)
    -- obj = nil
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