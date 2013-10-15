require "../grid"
require "../cell"

describe Grid do
    it "contains 21 rows and 21 columns of cells" do
        g = Grid.new
        expect(g.cells.length).to eq(21)
        g.cells.each do |row|
            expect(row.length).to eq(21)
            row.each do |cell|
                expect(cell).to be_a(Cell)
            end
        end        
    end    
    
    describe "#neighbors" do
        it "validates the given row and column indices" do
            g = Grid.new
            expect { g.neighbors(21, 5) }.to raise_error(IndexError, "Row index is out of bounds")
            expect { g.neighbors(5, 21) }.to raise_error(IndexError, "Column index is out of bounds")
        end
        context "on a corner cell" do
            it "returns a list of the 3 neighboring cells" do
                g = Grid.new
                expect(g.neighbors(0, 0).length).to eq(3)
                expect(g.neighbors(0, 20).length).to eq(3)
                expect(g.neighbors(20, 0).length).to eq(3)
                expect(g.neighbors(20,20).length).to eq(3)
            end
        end
        context "on a border cell" do
            it "returns a list of the 5 neighboring cells" do
                g = Grid.new
                expect(g.neighbors(0, 2).length).to eq(5)
                expect(g.neighbors(5, 0).length).to eq(5)
                expect(g.neighbors(20, 2).length).to eq(5)
                expect(g.neighbors(5, 20).length).to eq(5)
            end
        end
        context "on an inner cell" do
            it "returns a list of the 8 neighboring cells" do
                g = Grid.new
                expect(g.neighbors(2,2).length).to eq(8)
                expect(g.neighbors(10,12).length).to eq(8)
            end
        end
    end
end
