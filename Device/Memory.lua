-----------------------------------------------------------------------------------------
--
-- DEVICE MEMORY HELPER FUNCTIONS
--
-----------------------------------------------------------------------------------------

local memory = {}

function _printMemUsage()
  local memUsed = (collectgarbage("count"))
  local texUsed = system.getInfo( "textureMemoryUsed" ) / 1048576 -- Reported in Bytes
  
  print("\n---------MEMORY USAGE INFORMATION---------")
  print("System Memory: ", string.format("%.00f", memUsed), "KB")
  print("Texture Memory:", string.format("%.03f", texUsed), "MB")
  print("------------------------------------------\n")
end

memory.print = function()
  Runtime:addEventListener( "enterFrame", _printMemUsage)
end

return memory