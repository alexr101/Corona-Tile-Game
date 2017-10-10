local graphics = {}

graphics.radiate = function(obj)

  function glow(obj)
    transition.to( obj, { time=1000, alpha=.8, 
      onComplete = function() 
        dimmer(self)
      end} )
  end


  function dimmer(obj)
    transition.to( obj, { time=800, alpha=1, 
      onComplete=function() 
        glow(obj)
      end} )
  end

  glow(obj)
end

return graphics 