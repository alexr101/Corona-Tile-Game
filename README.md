# Gridlock-Corona
2D Grid Based Game under Development.

![alt text]( https://raw.githubusercontent.com/alexr101/Gridlock-Corona/master/assets/screenshots/screenshot.png )

## Setup
Gameplay is not setup, but you can demo the basic functionality by downloading Corona SDK at https://coronalabs.com/ 
and opening the project's main file with Corona's simulator.

## Gameplay
You can move the player 'blue orb' by swiping tiles. Tile functionality is based on its color at the moment.

Gray: regular swipable tile  
lightGray: generates electricity   
darkGrey: unmovable tile  
star: consumable obj  
purple: clicking on tile will make player jump if player is on it 

## Configurable things
You can change the following things in Game.config

levelSpeed 
tiles (columns)
rows

## LevelBuilder

To use the level builder go to Game.Config and set config.LevelBuilder.active to true and config.gridData to 'mock'. 
You will start with a blank level. You can click on any spot to change tile type. If you'd like to the level you created on 
app refresh then set config.gridData to 'json'.

## Architecture

* Runtime - Handles all functionality executed on every frame. Split up into Object Oriented Runtime Behaviors
* Sprites - Creates Sprites, and makes its sheets and sequences available by object name. (ie Sprite.electricity.sheet) Used in Game Blocks to give each object its own sprite and sequence properties on creation. This gives better flexibility to use these when needed.
* UI - Handles UI related procedures. ie GraphicEffects
* Util - Utilities for general tasks. Split up by general functionality (ie File, Math, etc)
* Physics
    * CollisionHandlers - Object Specific Collision Handler functions
    * Main - General Physic Classes
* Map - It's made up of 3 components that work together to create the node connected, tile based grid map.
    * Grid - It is responsible for creating the Grid map. Keeps track of rows and column numbers. The Tile & Node system is interwoven into creation just so we don't have to re-iterate through the whole Grid to add these connections. It has helper functions like "UpdateNodeConnections" for handling user tile swaps and keeping track of connections too. It has helper function like "CreateOutOfGridObj" & "FillSpace" to fill Tiles with their UI graphics, events & properties.
    * Node - Simple Node that connections to up, right, down & left Nodes.
    * Tile - Fill a grid space with it's own properties that include images, event handlers, tile type properties, and Corona Objects.
* Services - These are more like helper functions used for different game objects.
    * ObjectGenerator - Keeps a list of all gameObj Types and meta-data properties so we can reference them when filling up our Tiles


