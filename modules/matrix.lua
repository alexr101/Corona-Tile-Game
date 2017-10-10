local matrix = {}
local Table = require('modules.Table')

matrix.create = function(x, y)
  grid = {}

  for i = 1, x do
    grid[i] = {}

    for j = 1, y do
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