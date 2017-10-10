-- Add prototype func
local Table = {}

Table.forEach = function(table, cb)
  for i = #table, 1, -1 do
    cb(table[i].x)
  end
end

Table.length = function(table)
  local count = 0

  for _ in pairs(T) do 
    count = count + 1 
  end
  
  return count
end


return Table