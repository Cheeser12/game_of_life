def gen_random()
  r = Random.new
  alive_chance = r.rand(0.3..0.6)

  f = File.new("seeds/random.txt", "w")
  21.times do |i|
    21.times do |j|
      f << "#{i} #{j}\n" if r.rand <= alive_chance
    end
  end

  f.close
end
