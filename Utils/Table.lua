-----------------------------------------------------------------------------------------
--
-- Table Util
--
-----------------------------------------------------------------------------------------

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

-- Copy all layers of a table 
Table.deepCopy = function(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

-- Convert a table to JSON.
Table.toJson = function(table)
  local json = require( "json" )

  local data = json.encode( table, { indent=true } )

  return data
end

-- Get index of value in table
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

-- Print all elements in arr 
Table.printArr = function(arr)
  for i = 1, table.getn(arr), 1 do
    local element = arr[i]
    print(element)
  end

end

-- Print matrix. ie matrix = [ [1,2], [2,3], [3,5] ]
Table.printMatrix = function(matrix)

  for i = 1, table.getn(matrix), 1 do
    local row = matrix[i]

    for j = 1, table.getn(row), 1 do

      local element = row[j]

      print(i .. ':' .. j .. ':' .. element)

    end

  end
end

-- wut?
Table.print = function(table)

  for index, data in ipairs(table) do
    print(index)

    for key, value in pairs(data) do
        print('\t', key, value)
    end
  end

end

return Table