class Node
  attr_accessor :adjacent, :value
  
  def initialize(value)
    @adjacent = []
    @value = value
  end
  
  def add_adjacent(node)
    @adjacent << node
  end
  
  def to_s
    "Node Value: #{@value}"
  end
  
end