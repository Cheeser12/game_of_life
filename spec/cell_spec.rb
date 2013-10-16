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
end
