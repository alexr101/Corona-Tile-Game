-- Add prototype func
local Table = {}

Table.forEach = function(table, cb)
  for i = #table, 1, -1 do
    cb(table[i])
  end
end

Table.length = function(table)
  local count = 0

  for _ in pairs(T) do 
    count = count + 1 
  end
  
  return count
end

Table.print = function(table)

  for index, data in ipairs(table) do
    print(index)

    for key, value in pairs(data) do
        print('\t', key, value)
    end
  end

end


return Table