local Node = {}

Node = {
  val = nil,
  up = nil,
  down = nil,
  left = nil,
  right = nil
}

Node.new = function(val)
  local newNode = {}
	local node_mt = { __index = Node }
	newNode.val = val

  setmetatable(newNode, node_mt) 

  return newNode
end


Node.createRow = function(limit)
  if(limit == 0) then return nil end

  local newNode = Node.new(limit)
        newNode.right = Node.createRow(limit-1)
  
  return newNode -- returns leftmost Node
end

return Node