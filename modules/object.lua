local object = {}

object.remove = function(obj)
  display.remove(obj)
  obj = nil
end

return object