require "../cell"

describe Cell do
    it "is dead when created" do
        cell = Cell.new
        expect(cell.alive).to eq(false)
    end
end
