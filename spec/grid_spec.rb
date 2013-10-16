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

    describe "#new" do
        it "accepts a list of initial living cell coordinates when created" do
            g = Grid.new([[5, 8], [1, 2], [3, 6]]) 
            expect(g.cells[5][8].alive).to eq(true)
            expect(g.cells[1][2].alive).to eq(true)
            expect(g.cells[3][6].alive).to eq(true)
        end 
        
        it "validates the list of coordinates given to it" do
            expect { Grid.new([[3, 5, 6]]) }.to raise_error(ArgumentError,
                "Invalid number of coordinates")
            expect { Grid.new([[22, 5]])}.to raise_error(IndexError,
                "Coordinates out of bounds")
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

    describe "#to_s" do
      it "outputs the grid of cells" do
        g = Grid.new
        expect(g.to_s).to eq(("- "*21 + "\n")*21)
        
        # Try with some cells set to alive
        g.cells[4][10].alive = true
        g.cells[5][11].alive = true
        g.cells[6][12].alive = true
        
        first_four = ("- "*21 + "\n")*4
        fifth = ("- "*10 + "* " + "- "*10 + "\n")
        sixth = ("- "*11 + "* " + "- "*9 + "\n")
        seventh = ("- "*12 + "* " + "- "*8 + "\n")
        last_fourteen = ("- "*21 + "\n")*14
        target_grid = first_four + fifth + sixth + seventh + last_fourteen
        
        expect(g.to_s).to eq(target_grid)
      end
    end
    
    describe "#update" do
        it "updates each cell based on its neighbors" do
            g = Grid.new
            
            # (0, 0) has two live neighbors, so it should live
            g.cells[0][0].alive = true
            g.cells[0][1].alive = true
            g.cells[1][0].alive = true
            
            # (5, 5) is dead but has three live neighbors,
            # so it should become alive next iteration
            g.cells[5][4].alive = true
            g.cells[5][6].alive = true
            g.cells[6][5].alive = true
            
            # (12, 12) has only one live neighbor, so it should
            # should die
            g.cells[12][12].alive = true
            g.cells[12][13].alive = true
    
            g.update
            expect(g.cells[0][0].alive).to eq(true)
            expect(g.cells[5][5].alive).to eq(true)
            expect(g.cells[12][12].alive).to eq(false)
        end
    end
end
