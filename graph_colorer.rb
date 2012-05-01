#!/usr/bin/env ruby
load 'graph.rb'
load 'node.rb'

filename = ARGV[0]

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