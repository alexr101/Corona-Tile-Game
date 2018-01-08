local swipe = {}
local RowBehavior = require('Game.Behaviors.Row')

-- I think self is the touched object
-- TODO: Verify this
swipe.handler = function(event)
  local swipeOffset = 50
  local target = event.target

  local Grid = require('Game.Map.Grid')
  local Node = require('Game.Map.Node')

  if ( event.phase == "began" ) then    
      display.getCurrentStage():setFocus( target )
      target.isFocus = true
      print('clicked: ' .. target.info.name)
      -- Node.seeAll({row = target.coordinates.row, column = target.coordinates.column })

  end

  if (event.phase == "ended") then
    yEnd = event.y
    xEnd = event.x


    local row = event.target.coordinates.row
    local column = event.target.coordinates.column
    local direction = ''

    -- Node.seeAll({row = row, column = column })

    if     xEnd > event.xStart + swipeOffset then
      direction = 'right'
    elseif xEnd < event.xStart - swipeOffset then
      direction = 'left'
    elseif yEnd < event.yStart - swipeOffset then
      direction = 'up'
    elseif yEnd > event.yStart + swipeOffset then
      direction = 'down'
    end

    if direction ~= '' then
      Grid.swap({
        direction = direction,
        coordinates = { row = row, column = column }
      })

      -- RowBehavior.printRow(row)
      RowBehavior.update(row)
      if(direction == 'up') then
        RowBehavior.update(row+1)
      elseif(direction == 'down') then
        RowBehavior.update(row-1)
      end
    end

    display.getCurrentStage():setFocus( nil )
    target.isFocus = nil
  end
end

return swipe