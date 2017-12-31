local graphics = {}

graphics.radiate = function(obj, options)

  local alphaHigh = options.alphaHigh
  local alphaLow = options.alphaLow
  local speedGlow = options.speedGlow
  local speedDimmer = options.speedDimmer

  function glow(obj)
    transition.to( obj, { 
      time = speedGlow, 
      alpha = alphaLow, 
      onComplete = function() 
        dimmer(obj)
      end
    })
  end


  function dimmer(obj)
    transition.to( obj, { 
      time = speedDimmer, 
      alpha = alphaHigh, 
      onComplete=function() 
        glow(obj)
      end
    })
  end

  glow(obj)
end

return graphics 