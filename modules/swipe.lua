local swipe = {}

-- I think self is the touched object
-- TODO: Verify this
swipe.handler = function(self, event)
	local swipeOffset = 50

	if ( event.phase == "began" ) then
    -- Set touch focus
    display.getCurrentStage():setFocus( self )
    self.isFocus = true
  end

  if (event.phase == "ended") then
    yEnd = event.y
    xEnd = event.x

    if     xEnd > event.xStart + swipeOffset then
      -- right

    elseif xEnd < event.xStart - swipeOffset then
      -- left

    elseif yEnd < event.yStart - swipeOffset then
      -- up

    elseif yEnd > event.yStart + swipeOffset then
      -- down
    end

    -- Reset touch focus
    display.getCurrentStage():setFocus( nil )
    self.isFocus = nil
  end
end

return swipe