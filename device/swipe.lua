local swipe = {}

-- I think self is the touched object
-- TODO: Verify this
swipe.handler = function(event)
  local swipeOffset = 50
  local target = event.target

  if ( event.phase == "began" ) then    
      display.getCurrentStage():setFocus( target )
      target.isFocus = true
  end

  if (event.phase == "ended") then
    yEnd = event.y
    xEnd = event.x

    local Grid = require('game.map.Grid')

    local row = event.target.coordinates.row
    local column = event.target.coordinates.column
    local direction = ''

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
    end

    display.getCurrentStage():setFocus( nil )
    target.isFocus = nil
  end
end

return swipe