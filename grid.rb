require_relative "./cell"

class Grid
  attr_reader :cells 

  def initialize(*args)
    if args.size == 1 || args.size == 0 then
      @cells = Array.new(21) { Array.new(21) { Cell.new } }
    end

    if args.size == 1 then
      living = read_file(args[0])
      living.each {|coord| populate_grid(coord) }
    end
  end

  def neighbors(i, j)
    raise IndexError, "Row index is out of bounds"    if (i < 0 || i > 20)
    raise IndexError, "Column index is out of bounds" if (j < 0 || j > 20)
    get_neighbors(i, j)
  end

  def to_s
    grid = ""
    @cells.each do |row|
      grid += row_to_s(row) + "\n"
    end
    grid
  end

  def update
    new_cells = Array.new(21) { Array.new(21) { Cell.new } }

    update_cells do |i,j,new_alive|
      new_cells[i][j].alive = new_alive
    end

    @cells = new_cells
  end

  private

  def update_cells
    @cells.each_index do |i|
      @cells.each_index do |j|
        cell = @cells[i][j]
        yield i, j, update_cell(cell, neighbors(i, j))
      end
    end
  end

  def read_file(file)
    raise IOError, "File does not exist" unless File.exists?(file)
    f = File.new(file)
    coord_list = parse_coords(f) 
    coord_list
  end

  def update_cell(cell, neighbors)
    n_alive = 0
    
    neighbors.each do |neighbor|
      n_alive += 1 if neighbor.alive
    end
    
    new_alive(cell, n_alive)
  end

  def get_neighbors(i, j)
    neighbors = []
    neighbors << @cells[i-1][j]   unless i == 0
    neighbors << @cells[i-1][j+1] unless i == 0  || j == 20
    neighbors << @cells[i][j+1]   unless j == 20
    neighbors << @cells[i+1][j+1] unless i == 20 || j == 20
    neighbors << @cells[i+1][j]   unless i == 20
    neighbors << @cells[i+1][j-1] unless i == 20 || j == 0
    neighbors << @cells[i][j-1]   unless j == 0
    neighbors << @cells[i-1][j-1] unless i == 0  || j == 0
    neighbors
  end

  def parse_coords(f)
    coord_list = []
    f.each_line do |line|
      line.chomp
      coord_list << parse_nums(line)
    end
    coord_list
  end

  def parse_nums(line)
    nums = line.split(" ")
    raise ArgumentError, 
          "Invalid number of coordinates" if nums.length != 2

    i = nums[0].to_i
    j = nums[1].to_i
    raise IndexError, "Coordinates out of bounds" if (i < 0 || j < 0 || 
                                                      i >= 21 || j >= 21)
    [i, j]
  end

  def new_alive(cell, n_alive)
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

  def row_to_s(row)
    row_s = ""
    row.each do |cell|
       row_s += cell.to_s + " "
    end 
    row_s
  end

  def populate_grid(coord)
    i = coord[0]
    j = coord[1]
    @cells[coord[0]][coord[1]].alive = true
  end
end
