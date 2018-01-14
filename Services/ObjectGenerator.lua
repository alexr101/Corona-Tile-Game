local ObjectGenerator = {}

ObjectGenerator.MineMagnet = require('Game.Blocks.MineMagnet')
ObjectGenerator.Star = require('Game.Blocks.Star')
ObjectGenerator.Electricity = require('Game.Blocks.Electricity')
ObjectGenerator.ElectricityGenerator = require('Game.Blocks.ElectricityGenerator')

ObjectGenerator.Rock = require('Game.Blocks.Rock')
ObjectGenerator.RockCrumbling = require('Game.Blocks.RockCrumbling')
ObjectGenerator.EmptySpace = require('Game.Blocks.EmptySpace')
ObjectGenerator.DebugSpace = require('Game.Blocks.DebugSpace')


ObjectGenerator.objectsInGridArray = {
    ObjectGenerator.EmptySpace,
    ObjectGenerator.Star,
    ObjectGenerator.Rock,
    ObjectGenerator.RockCrumbling,
    ObjectGenerator.ElectricityGenerator
}

ObjectGenerator.objectsOutOfGridArray = {
    ObjectGenerator.MineMagnet,
}

ObjectGenerator.objectsReactive = {
    ObjectGenerator.Electricity
}

ObjectGenerator.get = function(name)
    return ObjectGenerator[name]
end

ObjectGenerator.randomOutOfGrid = function()
    return ObjectGenerator.objectsOutOfGridArray[ math.random(1, table.getn(ObjectGenerator.objectsOutOfGridArray) ) ]
end

ObjectGenerator.randomInGrid = function() 
    return ObjectGenerator.objectsInGridArray[ math.random(1, table.getn(ObjectGenerator.objectsInGridArray) ) ]
end

return ObjectGenerator