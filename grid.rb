require_relative "./cell"

class Grid
  attr_reader :cells

  def initialize(*args)
    if args.size == 1 || args.size == 0 then
        @cells = Array.new(21) { Array.new(21) {Cell.new}}
    end

    if args.size == 1 then
        living = args[0]
        living.each do |coord|
            raise ArgumentError, "Invalid number of coordinates" if (
                coord.length != 2)

            i = coord[0]
            j = coord[1]

            raise IndexError, "Coordinates out of bounds" if (
                i < 0 || j < 0 || i >= 21 || j >= 21)
            @cells[coord[0]][coord[1]].alive = true
        end
    end
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

  def to_s
      grid = ""
      @cells.each do |row|
         row.each do |cell|
              grid += cell.to_s + " "
         end
         grid += "\n"
      end
      grid
  end

  def update
      new_cells = Array.new(21) { Array.new(21) { Cell.new } }

      @cells.each_index do |i|
          @cells.each_index do |j|
              cell = @cells[i][j]
              new_cells[i][j].alive = cell.update(neighbors(i, j))
          end
      end

      @cells = new_cells
  end
end
