require_relative "./cell"

class Grid
    attr_reader :cells
  
    def initialize
        @cells = Array.new(21) { Array.new(21) {Cell.new}}
    end
    
    def neighbors(i, j)
        raise IndexError, "Row index is out of bounds" if (i < 0 || i > 20)
        raise IndexError, "Column index is out of bounds" if (j < 0 || j > 20)
        
        neighbors = []
        neighbors << @cells[i-1][j] unless i == 0
        neighbors << @cells[i-1][j+1] unless i == 0 || j == 20
        neighbors << @cells[i][j+1] unless j == 20
        neighbors << @cells[i+1][j+1] unless i == 20 || j == 20
        neighbors << @cells[i+1][j] unless i == 20
        neighbors << @cells[i+1][j-1] unless i == 20 || j == 0
        neighbors << @cells[i][j-1] unless j == 0
        neighbors << @cells[i-1][j-1] unless i == 0 || j == 0
        
        neighbors
    end
end
