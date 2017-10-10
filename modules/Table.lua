-- Add prototype func
function test()

end

local tableMT = getmetatable({})
tableMT.__index['test'] = test