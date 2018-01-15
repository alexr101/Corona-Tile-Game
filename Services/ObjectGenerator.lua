local ObjectGenerator = {}

ObjectGenerator.MineMagnet = require('Game.Blocks.MineMagnet')
ObjectGenerator.Star = require('Game.Blocks.Star')
ObjectGenerator.Electricity = require('Game.Blocks.Electricity')
ObjectGenerator.ElectricityGenerator = require('Game.Blocks.ElectricityGenerator')

ObjectGenerator.Rock = require('Game.Blocks.Rock')
ObjectGenerator.RockCrumbling = require('Game.Blocks.RockCrumbling')
ObjectGenerator.EmptySpace = require('Game.Blocks.EmptySpace')
ObjectGenerator.DebugSpace = require('Game.Blocks.DebugSpace')
ObjectGenerator.UnmovableSpace = require('Game.Blocks.UnmovableSpace')

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

ObjectGenerator.allObjects = {
    ObjectGenerator.EmptySpace,
    ObjectGenerator.Star,
    ObjectGenerator.Rock,
    ObjectGenerator.RockCrumbling,
    ObjectGenerator.ElectricityGenerator,
    ObjectGenerator.Electricity
}



ObjectGenerator.names = {
    ObjectGenerator.EmptySpace.name,
    ObjectGenerator.Star.name,
    ObjectGenerator.Rock.name,
    ObjectGenerator.RockCrumbling.name,
    ObjectGenerator.ElectricityGenerator.name,
    ObjectGenerator.Electricity.name

}

ObjectGenerator.next = function(name)
    local Table = require('Utils.Table')
    local i = Table.getIndex(ObjectGenerator.names, name) + 1

    if(i > table.getn(ObjectGenerator.names) ) then
        i = 1
    end
    
    print(ObjectGenerator.allObjects[1].name)

    return ObjectGenerator.allObjects[i]
end

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