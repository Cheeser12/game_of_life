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

        # We don't want to change the internal state of this cell!
        # It would affect other cells when the grid updates in an
        # iteration. Instead, we just return the next state
        # so the grid can construct a new cell
        new_alive = @alive
        if @alive then
            new_alive = false if (n_alive < 2 || n_alive > 3)
        else
            new_alive = true if (n_alive == 3)            
        end
        new_alive
    end
end
