require "../cell"

describe Cell do
  it "is dead when created" do
    cell = Cell.new
    expect(cell.alive).to eq(false)
  end
  
  describe "#to_s" do
    it "outputs a symbol representing if it's alive/dead" do
      cell = Cell.new
      expect(cell.to_s).to eq("\x1b[0m-")
      
      cell.alive = true
      expect(cell.to_s).to eq("\x1b[36;1m*")
    end
  end
end
