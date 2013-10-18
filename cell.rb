class Cell
  attr_accessor :alive

  def initialize()
    @alive = false
  end
    
  def to_s
    if @alive then
      "\x1b[36;1m*"    
    else
      "\x1b[0m-"
    end
  end
end
