local node = {}

node = {
  val = nil,
  up = nil,
  down = nil,
  left = nil,
  right = nil
}

node.new = function(val)
  local newNode = {}
	local node_mt = { __index = node }
	newNode.val = val

  setmetatable(newNode, node_mt) 

  return newNode
end

node.createRow = function(limit)
  if(limit == 0) then return nil end

  local newNode = node.new(limit)
        newNode.right = node.createRow(limit-1)
  
  return newNode -- returns leftmost node
end

return node