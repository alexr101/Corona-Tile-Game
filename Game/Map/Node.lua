local Node = {}

Node = {
  val = nil,
  up = nil,
  down = nil,
  left = nil,
  right = nil
}

-- create a new node
Node.new = function(val)
  local newNode = {}
	local node_mt = { __index = Node }
	newNode.val = val

  setmetatable(newNode, node_mt) 

  return newNode
end

Node.updatePositions = function(options)
  local row = options.row
  local column = options.column
  local directions = options.directions or {'all'}
  local Grid = require('Game.Map.Grid')
  local Table = require('Utils.Table')
  local newNode = options.newNode

  if(options.newNode == nil or options.newNode == true) then
    Grid.matrix[row][column].node = Node.new()
  end

  -- up
  if (Grid.matrix[row+1] ~= nil and 
      (Table.hasValue(directions, 'all') or Table.hasValue(directions, 'up') ) ) then
    Grid.matrix[row][column].node.up = Grid.matrix[row+1][column]
    Grid.matrix[row+1][column].node.down = Grid.matrix[row][column]
  end
  -- down
  if (Grid.matrix[row-1] ~= nil and 
      (Table.hasValue(directions, 'all') or Table.hasValue(directions, 'down') ) ) then
    Grid.matrix[row][column].node.down = Grid.matrix[row-1][column]
    Grid.matrix[row-1][column].node.up = Grid.matrix[row][column]
  end
  -- left
  if (Grid.matrix[row][column+1] ~= nil and 
      (Table.hasValue(directions, 'all') or Table.hasValue(directions, 'left') ) ) then
    Grid.matrix[row][column].node.right = Grid.matrix[row][column + 1]
    Grid.matrix[row][column+1].node.left = Grid.matrix[row][column]
  end
  -- right
  if (Grid.matrix[row][column-1] ~= nil and 
      (Table.hasValue(directions, 'all') or Table.hasValue(directions, 'right') ) ) then
    Grid.matrix[row][column].node.left = Grid.matrix[row][column - 1]
    Grid.matrix[row][column-1].node.right = Grid.matrix[row][column]
  end
end

-- print all node properties
Node.seeAll = function(options)
  local Grid = require('Game.Map.Grid')
  local row = options.row
  local column = options.column
  local obj = Grid.matrix[row][column]

  if(obj.node.up ~= nil) then
    print('up: ' .. obj.node.up.info.name)
  end
  if(obj.node.down ~= nil) then
    print('down: ' .. obj.node.down.info.name)
  end
  if(obj.node.right ~= nil) then
    print('right: ' .. obj.node.right.info.name)
  end
  if(obj.node.left ~= nil) then
    print('left: ' .. obj.node.left.info.name)
  end
end

Node.updateSwapPositions = function(options)
  local row = options.row
  local column = options.column
  local targetRow = options.targetRow
  local targetColumn = options.targetColumn

  Node.updatePositions({ 
    row = row,
    column = column,
  })

  Node.updatePositions({ 
    row = targetRow,
    column = targetColumn,
  })
end

-- We don't use this....but its nice to have
-- Creates a row of Nodes from left to right
-- limit = rowlength
-- initial call should be createRow(x, nil)
Node.createRow = function(limit, leftNode)
  if(limit == 0) then return nil end -- rightmost node.right = nil

  local newNode = Node.new(limit)
  newNode.right = Node.createRow(limit-1, newNode)
  newNode.left = leftNode
  
  return newNode -- returns leftmost Node
end

return Node