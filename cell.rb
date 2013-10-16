class Cell
    attr_accessor :alive

    def initialize()
        @alive = false
    end
    
    def to_s
        if @alive then
            "*"
        else
            "-"
        end
    end
    
    def update(neighbors)
        n_alive = 0
        
        neighbors.each do |cell|
            n_alive += 1 if cell.alive
        end

        if @alive then
            @alive = false if (n_alive < 2 || n_alive > 3)
        else
            @alive = true if (n_alive == 3)            
        end
        @alive
    end
end
