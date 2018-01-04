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



Node.seeAll = function(options)
  local Grid = require('game.map.Grid')
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



Node.updatePositions = function(options)
  local row = options.row
  local column = options.column
  local directions = options.directions or {}
  local Grid = require('game.map.Grid')
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

Node.updateSwapPositions = function(options)
  local Grid = require('game.map.Grid')
  local row = options.row
  local column = options.column
  local targetRow = options.targetRow
  local targetColumn = options.targetColumn
  local direction = options.direction
  local nodeDirections1
  local nodeDirections2

  print(Grid.matrix[targetRow][targetColumn])
  Grid.matrix[row][column].node = Node.new()
  Grid.matrix[targetRow][targetColumn].node = Node.new()

  -- set directions and manual update for the actual swappers
  if direction == 'up' then
    nodeDirections1 = {'left', 'up', 'right'}
    nodeDirections2 = {'left', 'down', 'right'}
    Grid.matrix[row][column].node.down = Grid.matrix[targetRow][targetColumn]
    Grid.matrix[targetRow][targetColumn].node.up = Grid.matrix[row][column]
  elseif direction == 'down' then
    nodeDirections1 = {'left', 'down', 'right'}
    nodeDirections2 = {'left', 'up', 'right'}
    Grid.matrix[row][column].node.up = Grid.matrix[targetRow][targetColumn]
    Grid.matrix[targetRow][targetColumn].node.down = Grid.matrix[row][column]
  elseif direction == 'right' then
    nodeDirections1 = {'up', 'right', 'down'}
    nodeDirections2 = {'up', 'left', 'down'}
    Grid.matrix[row][column].node.left = Grid.matrix[targetRow][targetColumn]
    Grid.matrix[targetRow][targetColumn].node.right = Grid.matrix[row][column]
  elseif direction == 'left' then
    nodeDirections1 = {'up', 'left', 'down'}
    nodeDirections2 = {'up', 'right', 'down'}
    Grid.matrix[row][column].node.right = Grid.matrix[targetRow][targetColumn]
    Grid.matrix[targetRow][targetColumn].node.left = Grid.matrix[row][column]
  end

  Node.updatePositions({ 
    row = row,
    column = column,
    directions = nodeDirections1,
    newNode = false
  })

  Node.updatePositions({ 
    row = targetRow,
    column = targetColumn,
    directions = nodeDirections2,
    newNode = false
  })
end


Node.createRow = function(limit)
  if(limit == 0) then return nil end

  local newNode = Node.new(limit)
        newNode.right = Node.createRow(limit-1)
  
  return newNode -- returns leftmost Node
end

return Node