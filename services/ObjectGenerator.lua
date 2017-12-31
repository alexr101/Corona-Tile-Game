local ObjectGenerator = {}

ObjectGenerator.MineMagnet = require('game.blocks.MineMagnet')
ObjectGenerator.Star = require('game.blocks.Star')
ObjectGenerator.Electricity = require('game.blocks.Electricity')
ObjectGenerator.ElectricityGenerator = require('game.blocks.ElectricityGenerator')

ObjectGenerator.Rock = require('game.blocks.Rock')
ObjectGenerator.RockCrumbling = require('game.blocks.RockCrumbling')
ObjectGenerator.EmptySpace = require('game.blocks.EmptySpace')

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

ObjectGenerator.randomOutOfGrid = function()
    return ObjectGenerator.objectsOutOfGridArray[ math.random(1, table.getn(ObjectGenerator.objectsOutOfGridArray) ) ]
end

ObjectGenerator.randomInGrid = function() 
    return ObjectGenerator.objectsInGridArray[ math.random(1, table.getn(ObjectGenerator.objectsInGridArray) ) ]
end

return ObjectGenerator