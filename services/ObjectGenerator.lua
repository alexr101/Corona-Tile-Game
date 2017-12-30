local ObjectGenerator = {}

ObjectGenerator.MineMagnet = require('game.objects.MineMagnet')
ObjectGenerator.Star = require('game.objects.Star')
ObjectGenerator.Electricity = require('game.objects.Electricity')
ObjectGenerator.ElectricityGenerator = require('game.objects.ElectricityGenerator')

ObjectGenerator.Rock = require('game.objects.Rock')
ObjectGenerator.RockCrumbling = require('game.objects.RockCrumbling')
ObjectGenerator.EmptySpace = require('game.objects.EmptySpace')

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