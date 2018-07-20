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
* Sprites - Creates Sprites, and makes its sheets and sequences available by object name. (ie Sprite.electricity.sheet) Used in Game Blocks to give object obj.sprite and obj.sequence properties.

