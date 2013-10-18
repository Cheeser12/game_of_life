#!/usr/bin/env ruby
require_relative "./grid"

raise ArgumentError, "Need file name argument" if ARGV[0] == nil
grid = Grid.new(ARGV[0])

print grid.to_s
sleep(0.5)

while true do
  grid.update 
  print "\r\e[21A\e[J" + grid.to_s
  sleep(0.5)
end
