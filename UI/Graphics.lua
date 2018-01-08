local graphics = {}

graphics.radiate = function(obj, options)

  local alphaHigh = options.alphaHigh
  local alphaLow = options.alphaLow
  local speedGlow = options.speedGlow
  local speedDimmer = options.speedDimmer

  local alpha = alphaHigh
  local speed = speedGlow

  function glow(obj)
    transition.to( obj, { 
      time = speedGlow, 
      alpha = alpha, 
      onComplete = function()
        switchEffects()
        glow()
      end
    })
  end

  function switchEffects()
      if alpha == alphaLow then
        alpha = alphaHigh
        speed = speedGlow
      else 
        alpha = alphaLow
        speed = speedDimmer
      end
  end

  glow(obj)
end

graphics.damageFlicker = function()
  local alphaHigh = 1
  local alphaLow = .5
  local alpha = alphaLow
  local flickerAmount = 5
  local speed = 300

  function flicker()
    transition.to( player, { 
      time = speed, 
      alpha = alpha, 
      onComplete = function() 
        switchEffects()
        if (flickerAmount > 0) then 
          flicker() 
        end
      end
    })
  end

  function switchEffects()
    if(alpha == alphaLow) then
      alpha = alphaHigh
    else
      alpha = alphaLow
      flickerAmount = flickerAmount + 1
    end
  end

end

return graphics 