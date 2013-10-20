#!/usr/bin/env ruby
require_relative "./grid"

raise ArgumentError, "Need file name argument" if ARGV[0] == nil
grid = Grid.new(ARGV[0])

print grid.to_s
sleep(0.5)

while true do
  grid.update 
  print "\r\e[21A\e[J" + grid.to_s

  # Exit program if we read in a "q" from input
  system("stty raw -echo")
  char = STDIN.read_nonblock(1) rescue nil
  system("stty -raw echo")
  break if /q/i =~ char

  sleep(0.5)
end
