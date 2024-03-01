# Qianlong's World
This repository will contain the game collaboratively developed in Paul Vierthaler's "Building Qianlong's World" class at William & Mary in Spring 2024.

## Organizational ethos
Below you will find tips on keeping our game organized. One key thing to remember: ALWAYS give credit when you include an asset found elsewhere. You can create a .txt file called 'credits.txt' if one does not exist, which you should use to explain where you found the asset, and information its license!

### Developing process
Before you make any changes, be sure to create a new branch in GitHub desktop. Make all of the changes you would like, and when you are ready to have them added to the main game, make a pull request. Please remember to routinely pull remote changes into your version of the game.

As you make changes, be sure to commit them frequently! It is best to have an individual commit for each thing you change.

### Levels
When you add a level create a folder with your name, and place the level scene within it. Keep your scripts local to this file. 

### Assets
Models, materials, textures, etc should go in their respective assets folder. 

#### Prefabs
When you build a Godot scene that you think can be reused across levels, please save it into the "prefabs" folder. First add a folder for the general category if it doesn't exist, then add it there.

## Project roadmap
Here are the planned features we would like to develop:

### User interface

#### guidance?
minimap/hud situation

#### Title Screen
'new game'
'continue'

#### Credits Screen
everybody who wants credit

### Sound
music
sound effects

### Environment
skybox
    different times of day
    different times of year
    dynamic day-night cycle

fog

### player controller
interaction functionality
let it fly?
speed it up
create a model for hte player
move from 1st person to third person

### textures
what did roads look like? cobblestone? dirt?