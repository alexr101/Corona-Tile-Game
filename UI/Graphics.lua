local graphics = {}

graphics.radiate = function(obj, options)

  local alphaHigh = options.alphaHigh or 1
  local alphaLow = options.alphaLow or .7
  local speedGlow = options.speedGlow or 1000
  local speedDimmer = options.speedDimmer or 600

  local alpha = alphaHigh
  local speed = speedGlow
  obj.flickering = false

  local function switchEffects()
      if alpha == alphaLow then
        alpha = alphaHigh
        speed = speedGlow
      else 
        alpha = alphaLow
        speed = speedDimmer
      end
  end

  function glow(obj) 

    if(obj.flickering == false) then   
      transition.to( obj, { 
        time = speed,
        alpha = alpha,
        onComplete = function()
          switchEffects()
          glow(obj)      
        end
      })
    else 
      local fn = function() glow(obj) end
      timer.performWithDelay(100, fn )
    end
  end

  glow(obj)
end

graphics.damageFlicker = function(obj)
  local alphaHigh = .5
  local alphaLow = .3
  local alpha = alphaLow
  local flickerAmount = 15
  local speed = 100

  obj.flickering = true


  function switchEffects()
    if(alpha == alphaLow) then
      alpha = alphaHigh
    else
      alpha = alphaLow
      flickerAmount = flickerAmount - 1
    end
  end

  function flicker(obj)
    transition.to( obj, { 
      time = speed, 
      alpha = alpha, 
      onComplete = function() 
        
        if (flickerAmount > 0) then
          switchEffects() 
          flicker(obj) 
        else
          obj.flickering = false
          obj.alpha = 1
        end
      end
    })
  end

  flicker(obj)


end

return graphics 