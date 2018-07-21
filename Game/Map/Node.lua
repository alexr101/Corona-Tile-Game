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