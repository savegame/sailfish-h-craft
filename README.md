# README #

### What is this repository for? ###

This repository contains the source-code for the game [H-Craft Championship](http://www.irrgheist.com/games.htm) from [Irrgheist](http://www.irrgheist.com).
See in  for more information.

### How to set it up? ###

Follow the instructions in doc/build.txt

### What's the license ###

The game sources are mostly under a z-lib license. A few files come with other, but similar liberal licenses. 
The needed libraries are using a mixture of free software licenses

### Discussions ###

Please use the [forum thread](http://irrlicht.sourceforge.net/forum/viewtopic.php?f=6&t=50627) in the Irrlicht forum for any questions about the code.
I will also follow reddit post on [/r/hcraft](http://www.reddit.com/r/hcraft/).

### About SailfishOS prot ###

This port builded with custom irrlicht engine port. H-Craft use OpenAL for play sound in game, but in SailfishOS it not work.
As writeen [here](http://www.irrgheist.com/hcraftsource.htm) the media files for game placed on [bitbucker](https://bitbucket.org/mzeilfelder/media_hc1), but you need read license, before use media (only for personal use now, not for public it).

### Build for SailfishOS ###
First, place media files in root of project in *media* folder. 
Second, just open **h-craft.pro** in SailfishIDE, and **add "CONFIG+=sailfish" to qmake configuration** in project setting.

