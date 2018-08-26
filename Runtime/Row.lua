-----------------------------------------------------------------------------------------
--
-- Handle Rows and all objects inside of them
--
-----------------------------------------------------------------------------------------


local Row = {}

-- Remove a row from UI & memory. Create a new Row upon completion.
Row.remover = function(obj)
  if(not Config.levelBuilder) then
    local removeLimit = obj.y > Screen.height + (AppState.tileSize)

    if(obj.coordinates ~= nil and obj.coordinates.column == Config.tiles-1 and removeLimit) then
      -- TODO: reinstate obj remover after finding bug
      RowBehaviors.delete(obj.coordinates.row)
      RowBehaviors.newRow()
    end
  end

end

return Row