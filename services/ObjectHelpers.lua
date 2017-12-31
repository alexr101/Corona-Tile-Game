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
    local row
    local column
    local obj1
    local objInfo

    if(obj.coordinates ~= nil) then
      row = obj.coordinates.row
      column = obj.coordinates.column
      obj1 = Grid.matrix[row][column]
      objInfo = Grid.matrix[row][column].info
    end

    local x = obj.x
    local y = obj.y
    
    obj:removeSelf()
    obj = nil
    -- Grid.matrix[row][column]:removeSelf()
    -- Grid.matrix[row][column] = nil

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
    if(false) then
      timer.performWithDelay( 1, replaceGrid )
    end
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