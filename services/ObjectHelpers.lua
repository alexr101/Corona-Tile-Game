local ObjectHelpers = {}

-- Optional: index
-- otherwise treated as an object
ObjectHelpers.remove = function(obj, index)
  local Grid = require('game.map.Grid')
  index = index or nil

  if index ~= nil then
    display.remove( tileTable[i] )
	  table.remove( tileTable, i )
    titleTable[i] = nil
  else
    local row = obj.coordinates.row
    local column = obj.coordinates.column
    local obj1 = Grid.matrix[row][column]

    local swapImage = function(oldImage, imageFile, width, height)
      local newImage = display.newImageRect(imageFile, width, height)

      newImage.x = oldImage.x
      newImage.y = oldImage.y
      oldImage:removeSelf()
      oldImage = nil
      AppState.add('score', 10)
      -- print(AppState.score)
      AppState.sceneGroup:insert(newImage)

      -- AppState.currentGame.sceneGroup:insert(newImage)
      return newImage
    end

    Grid.matrix[row][column] = swapImage(obj1, "assets/game-objects/rockTile.png", 50, 50)
    
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