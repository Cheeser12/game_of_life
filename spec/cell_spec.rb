require "../cell"

describe Cell do
  it "is dead when created" do
    cell = Cell.new
    expect(cell.alive).to eq(false)
  end
  
  describe "#to_s" do
    it "outputs a symbol representing if it's alive/dead" do
      cell = Cell.new
      expect(cell.to_s).to eq("-")
      
      cell.alive = true
      expect(cell.to_s).to eq("*")
    end
  end
  
  describe "#update" do
    it "decides the cell's next state depending on its neighbors states" do
      neighbors = Array.new(8) { Cell.new }
       
      cell = Cell.new
      cell.alive = true
      
      # Less than 2 live neighbors, should die 
      expect(cell.update(neighbors)).to eq(false)
      neighbors[0].alive = true
      expect(cell.update(neighbors)).to eq(false)    
      
      # 2-3 live neighbors, should live
      cell.alive = true
      neighbors[1].alive = true
      expect(cell.update(neighbors)).to eq(true)
      neighbors[2].alive = true
      
      # > 3 live neighbors, should die
      neighbors[3].alive = true
      expect(cell.update(neighbors)).to eq(false)
      
      # =3 live neighbors, should become alive
      neighbors[3].alive = false
      expect(cell.update(neighbors)).to eq(true)
    end
  end
end
