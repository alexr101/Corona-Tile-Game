-----------------------------------------------------------------------------------------
--
-- General Physics Class
--
-----------------------------------------------------------------------------------------


local Main = {}

-- Create screen border physics bounds. options.onSides vals = 'all', 'right', 'left', 'top', 'bottom'
-- ie createBounds( { onSides = {'right', 'left'} } )
Main.createBounds = function(options)

  local sides = options.onSides or {'all'}

  if ( Table.hasValue(sides, 'all') or Table.hasValue(sides, 'top') ) then
    local topWall = display.newRect (0, -1, Screen.width, 1)
    topWall.anchorX = 0
    topWall.isWall = true
    physics.addBody (topWall, "static", { bounce = 0.1} )
  end

  if ( Table.hasValue(sides, 'all') or Table.hasValue(sides, 'bottom') ) then
    local bottomWall = display.newRect (0, Screen.height, Screen.width, 1)
    bottomWall.anchorX = 0
    bottomWall.isWall = true
    physics.addBody (bottomWall, "static", { bounce = 0.1} )
  end

  if ( Table.hasValue(sides, 'all') or Table.hasValue(sides, 'left') ) then
    local leftWall = display.newRect(-1, 0, 1, Screen.height)
    leftWall.anchorY = 0
    leftWall.isWall = true
    physics.addBody (leftWall, "static", { bounce = 0.1} )
  end

  if ( Table.hasValue(sides, 'all') or Table.hasValue(sides, 'right') ) then
    local rightWall = display.newRect (Screen.width, 0, 1, Screen.height)
    rightWall.anchorY = 0
    rightWall.isWall = true
    physics.addBody (rightWall, "static", { bounce = 0.1} )
  end

end


return Main