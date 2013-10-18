require_relative "./grid"

grid = Grid.new("live.txt")

print grid.to_s
sleep(0.5)

while true do
  grid.update 
  print "\r\e[21A\e[J" + grid.to_s
  sleep(0.5)
end
