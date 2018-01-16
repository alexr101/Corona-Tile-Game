local swipe = {}
local RowBehavior = require('Game.Behaviors.Row')

-- I think self is the touched object
-- TODO: Verify this
swipe.handler = function(event)
  local swipeOffset = 50
  local target = event.target

  local Grid = require('Game.Map.Grid')
  local Node = require('Game.Map.Node')
  local Config = require('Game.Config')
  local ObjectHelpers = require('Services.ObjectHelpers')
  local File = require('Utils.File')

  if ( event.phase == "began" ) then    
      display.getCurrentStage():setFocus( target )
      target.isFocus = true
      -- print('clicked: ' .. target.info.name)
      -- Node.seeAll({row = target.coordinates.row, column = target.coordinates.column })

  end

  if (event.phase == "ended") then

    if(target.info.unmovable ~= true) then
      yEnd = event.y
      xEnd = event.x


      local row = target.coordinates.row
      local column = target.coordinates.column
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
    end

    if(Config.levelBuilder) then
      ObjectHelpers.replace(target, {
        getNext = true
      })
          
      local table = Grid.toTable()
      print(json)
      File.save('/LevelData/test.json', table)
    end



    display.getCurrentStage():setFocus( nil )
    target.isFocus = nil
  end
end

return swipe