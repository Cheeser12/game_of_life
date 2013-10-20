#!/usr/bin/env ruby
require_relative "./grid"
require_relative "./gen_random"

raise ArgumentError, "Need seed argument" if ARGV[0] == nil

if ARGV[0] == "random" then
  gen_random()
  seed_file = "seeds/random.txt"
else
  seed_file = "seeds/" + ARGV[0] + ".txt"
end

grid = Grid.new(seed_file)

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
