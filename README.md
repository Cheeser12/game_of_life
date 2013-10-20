Conway's Game of Life
=====================

An implementation of Conway's Game of Life using Ruby.
The main purpose of this is to practice using Ruby and RSpec,
so forgive any hideous mistakes.

Usage
-----
The entry point of the program is game.rb, and can be passed one of two
arguments:

  * the name of an example from the __seeds__ folder, minus the extension
    (i.e `./game.rb eureka`)

  * the argument `random`, which produces a random seed where 30-60% of
    the cells are initially alive


The program will then output the grid of cells and update it every
half-second. To quit the program, just press __q__.
