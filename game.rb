require_relative "./grid"

class Game
    attr_reader :grid

    def initialize(file)
        f = File.new(file)
        coord_list = Array.new
        
        f.each_line do |line|
            line.chomp
            nums = line.split(" ")
            coord_list << [nums[0].to_i, nums[1].to_i]
        end
        @grid = Grid.new(coord_list)
    end
end
