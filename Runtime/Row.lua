local Row = {}

Row.remover = function(obj)
  local removeLimit = obj.y > Screen.height + (AppState.tileSize)

  if(obj.coordinates ~= nil and obj.coordinates.column == Config.tiles-1 and removeLimit) then
    -- TODO: reinstate obj remover after finding bug
    RowBehaviors.delete(obj.coordinates.row)
    RowBehaviors.newRow()
  end

end

return Row