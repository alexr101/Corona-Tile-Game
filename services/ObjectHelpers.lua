local ObjectHelpers = {}

-- Optional: index
-- otherwise treated as an object
ObjectHelpers.remove = function(obj, index)
  local Grid = require('game.map.Grid')
  local Tiles = require('game.map.tiles')
  local ObjectGenerator = require('services.ObjectGenerator')
  local AppState = require('game.state')

  index = index or nil

  if index ~= nil then
    display.remove( tileTable[i] )
	  table.remove( tileTable, i )
    titleTable[i] = nil
  else
    -- get metadata
    local row
    local column
    local objInfo

    if(obj.coordinates ~= nil) then
      row = obj.coordinates.row
      column = obj.coordinates.column
      objInfo = Grid.matrix[row][column].info
    end

    -- get close proximity objects for transition position references
    local objForVerticalReference
    local objForHorizontalReference = Grid.matrix[row+1][column]

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

    
    obj:removeSelf()
    obj = nil

    -- replace the object if needed 
    -- hint: you'll probably always need it
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
      AppState.sceneGroup:insert(Grid.matrix[row][column])
    end

    -- for testing
    if(false) then
      timer.performWithDelay( 1, replaceGrid )
    end

    if(objInfo.consumable) then
      objInfo = ObjectGenerator.EmptySpace
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