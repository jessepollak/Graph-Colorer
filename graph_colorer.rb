#!/usr/bin/env ruby

filename = ARGV[0]

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

graph = Graph.new
File.open(filename) do |file|
  node_count, edge_count = file.gets.split.map {|x| x.to_i}
  
  (1..node_count).each do |i|
    graph.add_node(Node.new(i))
  end
  
  while (line = file.gets)
    a, b = line.split.map {|x| x.to_i}
    graph.add_edge(a, b)
  end
end

color_map = graph.color

File.open("output.txt", "w+") do |file|
  color_map.reduce(' ') do |s, el|
    file.puts "#{el.first} #{el.last}"
  end
end