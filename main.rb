require_relative "./game"

game = Game.new("live.txt")

print game.grid.to_s
sleep(0.5)
while true do
 game.grid.update 
 print "\r\e[21A\e[J" + game.grid.to_s
 sleep(0.5)
end
