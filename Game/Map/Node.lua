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