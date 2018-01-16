-- Add prototype func
local Table = {}

Table.forEach = function(tab, cb)
  for i = 1, table.getn(tab), 1 do
    cb(tab[i])
  end
end

Table.length = function(table)
  local count = 0

  for _ in pairs(T) do 
    count = count + 1 
  end
  
  return count
end

Table.toJson = function(table)
  local json = require( "json" )

  local data = json.encode( table, { indent=true } )

  return data
end

-- https://stackoverflow.com/questions/38282234/returning-the-index-of-a-value-in-a-lua-table
Table.getIndex = function(table, value)
  local index={}

  for k,v in pairs(table) do
    index[v]=k
  end

  return index[value]
end

Table.hasValue = function(table, val)
    
  for index, value in ipairs(table) do
      if value == val then
          return true
      end
  end

  return false
end

Table.printArr = function(arr)
  for i = 1, table.getn(arr), 1 do
    local element = arr[i]
    print(element)
  end

end

Table.printMatrix = function(matrix)

  for i = 1, table.getn(matrix), 1 do
    local row = matrix[i]

    for j = 1, table.getn(row), 1 do

      local element = row[j]

      print(i .. ':' .. j .. ':' .. element)

    end

  end
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