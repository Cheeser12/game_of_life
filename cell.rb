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
end
