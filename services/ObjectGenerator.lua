local ObjectGenerator = {}

ObjectGenerator.MineMagnet = require('game.objects.MineMagnet')
ObjectGenerator.Star = require('game.objects.Star')
ObjectGenerator.Electricity = require('game.objects.Electricity')
ObjectGenerator.ElectricityGenerator = require('game.objects.ElectricityGenerator')

ObjectGenerator.Rock = require('game.objects.Rock')
ObjectGenerator.RockCrumbling = require('game.objects.RockCrumbling')
ObjectGenerator.EmptySpace = require('game.objects.EmptySpace')

ObjectGenerator.objectsInGridArray = {
    EmptySpace,
    Star,
    Rock,
    RockCrumbling,
    ElectricityGenerator
}

ObjectGenerator.objectsOutOfGridArray = {
    MineMagnet,
}

ObjectGenerator.objectsReactive = {
    Electricity
}

ObjectGenerator.randomOutOfGrid = function()
    return ObjectGenerator.objectsOutOfGridArray[ math.random(1, table.getn(ObjectGenerator.objectsOutOfGridArray) ) ]
end


ObjectGenerator.randomInGrid = function() 
    return ObjectGenerator.objectsInGridArray[ math.random(1, table.getn(ObjectGenerator.objectsInGridArray) ) ]
end

return ObjectGenerator