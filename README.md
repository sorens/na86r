# North Atlantic 86 Simulation Library (na86r)

## Original Game

The original game, [North Atlantic '86](https://northatlantic86.com), was released in 1983 by the legendary game creator, [Gary Grigsby](https://en.wikipedia.org/wiki/Gary_Grigsby). The game featured two player (NATO v USSR) or a human player (NATO) against a computer player (USSR). The two players battled for control of the North Atlantic. The goal of the NATO player was to keep the sea lanes open and keep its allies in Europe supplied. The USSR goal was to deny the supplies to the British Isles, eliminate the threat to its naval forces at Iceland and the Faroes so that it coule operate uncontested in the North Atlantic. Game play included landing paratroopers, shore bombardment from battleships, carrier battle groups and countless warnings of "Incoming Vampires!". It was great fun to play!

![Original Box Front](docs/screen_shots/box-front.png "Box Cover")

## Summary

I needed a reason to practice coding and re-creating this game was more fun than the various coding exercises. The requirements:

1. Employ good coding practices
1. The game should be playable
1. Document in Github at https://github.com/sorens/na86r
1. Use ruby

This game project is broken into four chief components:

1. the data necessary to drive the game (IN_PROGRESS)
1. the game engine to prosecute the moves
1. the user interface that allows the player to play the game
1. the artificial intelligence engine to conduct the opponents moves

(This plan is copied from my c++ version, it might need to be adjusted for this older, ruby version of the project)

## Install

```shell
$ bin/setup
$ rspec

...

Finished in 6.79 seconds (files took 0.51399 seconds to load)
189 examples, 0 failures, 54 pending
```
