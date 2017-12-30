local ObjectGenerator = {}
local MineMagnet = require('game.objects.MineMagnet')
local Star = require('game.objects.Star')
local Electricity = require('game.objects.Electricity')



local objectsArray = {
    MineMagnet,
    Star,
    Electricity
}


ObjectGenerator.random = function() 
    return objectsArray[ math.random(1, table.getn(objectsArray) ) ]
end

return ObjectGenerator