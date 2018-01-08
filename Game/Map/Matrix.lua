local matrix = {}
local Table = require('Utils.Table')

matrix.create = function(rows, columns)
  grid = {}

  for i = 1, rows do
    grid[i] = {}

    for j = 1, columns do
      grid[i][j] = 0 
    end
  end
  
  return grid
end

matrix.addRow = function(grid, y)
  local xLength = Table.length(grid)

  for i = 1, y do
    grid[xLength+1][i] = 0
  end
end