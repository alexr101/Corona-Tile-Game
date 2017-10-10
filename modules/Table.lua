-- Add prototype func
local Table = {}

Table.forEach = function(table, cb)
  for i = #table, 1, -1 do
    cb(table[i].x)
  end
end

return Table