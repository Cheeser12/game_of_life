require "../game"

describe Game do
    describe "#new" do
        it "accepts a file with coordinate pairs for live cells" do
            # 0 0
            # 5 5
            # 12 12
            g = Game.new("test.txt")
            expect(g.grid.cells[0][0].alive).to eq(true)
            expect(g.grid.cells[5][5].alive).to eq(true)
            expect(g.grid.cells[12][12].alive).to eq(true)
        end
        
        it "throws an error when the file does not exist" do
            expect { Game.new("fakeFile.txt") }.to raise_error()
        end
    end
end
