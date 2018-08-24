-----------------------------------------------------------------------------------------
--
-- Object Helper Functions
--
-----------------------------------------------------------------------------------------

local ObjectService = {}

-- Optional: index
-- otherwise treated as an object
-- This should probably just be in Tiles
ObjectService.replace = function(obj, options)
  local Grid = require('Game.Map.Grid')
  local Tiles = require('Game.Map.Tiles')
  local ObjectGenerator = require('Services.ObjectGenerator')
  local AppState = require('Game.State')

  local objIsNotOutOfGrid = obj.coordinates ~= nil

  if(objIsNotOutOfGrid) then
    -- GET OBJ METADATA
    local row = obj.coordinates.row
    local column = obj.coordinates.column
    local objInfo = Grid.matrix[row][column].info


    -- GET CLOSE PROXIMITY OBJ FOR X & Y POSITION REFERENCES SINCE OUR OBJ WILL BE NIL FOR A SEC
    -- WE WILL LOSE ITS MOVEMENT FLOW WITH THE REST OF THE GRID
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

    -- GET X & Y POSITIONS
    local x = obj.x
    local y = obj.y
    if(!objInfo.consumable) then
      if (obj.moving == 'horizontally') then
        x = objForHorizontalReference.x
      else
        y = objForVerticalReference.y
      end
    end

    -- GET OBJ INFO
    if(options == nil or options.getNext == nil) then
      newObjInfo = ObjectGenerator.EmptySpace
    else
      newObjInfo = ObjectGenerator.next(obj.info.name) -- used for levelbuilder mode
    end 

    -- REPLACE THE OBJ
    if(objInfo.consumable ) then
      local replaceTileFn = Tiles.replace({
        oldObj = obj,
        newObjInfo = newObjInfo,
        x = x,
        y = y,
        row = row,
        column = column
      })

      timer.performWithDelay( 1, replaceTileFn )
    end
  end
end

-- Delete object. The Corona way :)
ObjectService.remove = function(obj)
  if( obj.removeSelf ~= nil ) then
    obj:removeSelf()
    obj = nil
  end
end

-- Is the object past a certain x or y coordinate limit?
ObjectService.pastLimit = function(self, direction, limit)
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

return ObjectService