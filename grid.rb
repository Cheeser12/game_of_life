require_relative "./cell"

class Grid
  attr_reader :cells 

  def initialize(*args)
    if args.size == 1 || args.size == 0 then
      @cells = Array.new(21) { Array.new(21) {Cell.new}}
    end

    if args.size == 1 then
      living = read_file(args[0])
      living.each do |coord|
        i = coord[0]
        j = coord[1]

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
        new_cells[i][j].alive = update_cell(cell, neighbors(i, j))
      end
    end

    @cells = new_cells
  end

  
  private

  def read_file(file)
    raise IOError, "File does not exist" unless File.exists?(file)
    f = File.new(file)
    coord_list = Array.new
    
    f.each_line do |line|
      line.chomp
      nums = line.split(" ")
      raise ArgumentError, "Invalid number of coordinates" if (
                nums.length != 2)

      i = nums[0].to_i
      j = nums[1].to_i
      raise IndexError, "Coordinates out of bounds" if (
          i < 0 || j < 0 || i >= 21 || j >= 21)
      coord_list << [i, j]
    end

    coord_list
  end

  def update_cell(cell, neighbors)
    n_alive = 0
    
    neighbors.each do |neighbor|
      n_alive += 1 if neighbor.alive
    end

    # We don't want to change the internal state of this cell!
    # It would affect other cells when the grid updates in an
    # iteration. Instead, we just return the next state
    # so the grid can construct a new cell
    new_alive = cell.alive
    if cell.alive then
      new_alive = false if (n_alive < 2 || n_alive > 3)
    else
      new_alive = true if (n_alive == 3)            
    end
    new_alive
  end
end
