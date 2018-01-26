local Util = {}

Util.createBounds = function(options)

  local sides = options.onSides or {'all'}

  if ( Table.hasValue(sides, 'all') or Table.hasValue(sides, 'top') ) then
    local topWall = display.newRect (0, -1, Screen.width, 1)
    topWall.anchorX = 0
    physics.addBody (topWall, "static", { bounce = 0.1} )
  end

  if ( Table.hasValue(sides, 'all') or Table.hasValue(sides, 'bottom') ) then
    local bottomWall = display.newRect (0, Screen.height, Screen.width, 1)
    bottomWall.anchorX = 0
    physics.addBody (bottomWall, "static", { bounce = 0.1} )
  end

  if ( Table.hasValue(sides, 'all') or Table.hasValue(sides, 'left') ) then
    local leftWall = display.newRect(-1, 0, 1, Screen.height)
    leftWall.anchorY = 0
    physics.addBody (leftWall, "static", { bounce = 0.1} )
  end

  if ( Table.hasValue(sides, 'all') or Table.hasValue(sides, 'right') ) then
    local rightWall = display.newRect (Screen.width, 0, 1, Screen.height)
    rightWall.anchorY = 0
    physics.addBody (rightWall, "static", { bounce = 0.1} )
  end

end


return Util