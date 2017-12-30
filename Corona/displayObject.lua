local oldNewRect = display.newRect -- old func

function display.newRect( ... ) -- func with added method
  local rect = oldNewRect( ... )

  function rect:foo( str )
      -- print( str )
  end

  function rect:pastLimit = function(direction, limit)
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

  return rect
end

-- usage

local rect = display.newRect( 0, 0, 40, 40 )
rect:foo( "hello" ) -- prints "hello"
rect:pastLimit('right', 100)