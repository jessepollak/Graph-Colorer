class Graph
  attr_accessor :nodes, :size
  
  def initialize
    @nodes = []
    @size = 0
  end
  
  def add_node(node)
    @nodes << node
    @size = @size + 1
  end
  
  def add_edge(a,b)
    node_a = get_node(a)
    node_b = get_node(b)
    node_a.add_adjacent(node_b)
    node_b.add_adjacent(node_a)
  end
  
  def get_node(value)
    @nodes[value - 1]
  end
  
  def color
    max_color = 0
    color_map = {}
    @nodes.each do |node|
      if max_color == 0
        color_map[node.value] = 1
        max_color = max_color + 1
      else
        possible = (1..max_color).to_a
        node.adjacent.each do |n|
          possible.delete color_map[n.value]
        end
        if possible.empty?
          max_color = max_color + 1
          color_map[node.value] = max_color
        else
          color_map[node.value] = possible[0]
        end
      end
    end
    return color_map
  end
end