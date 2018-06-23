# require "./Data_Structure_Exercise/skeleton/lib/00_tree_node.rb"
require "byebug"

class KnightPathFinder
  attr_reader :visited_positions, :root
  
  def initialize(starting_pos)
    @starting_pos = starting_pos
    @visited_positions = []
    @root = PolyTreeNode.new(@starting_pos)

    build_move_tree
  end 
  
  def build_move_tree
    queue = Queue.new
    queue.enq(@root)
    until queue.empty?
      byebug
      node = queue.deq
    # return node if node.value == final_pos
      next_moves = new_move_positions(node.value)
      next_moves = next_moves.map { |new_pos| node.add_child(PolyTreeNode.new(new_pos)) }
      next_moves.each { |next_move| queue.enq(next_move) }
    end
  end 
  
  def find_path(final_pos)
    build_move_tree(final_pos)
  end 
  
  def valid_moves(pos)
    square_range = (0..8).to_a
    result = [[pos.first+2, pos.last+1],[pos.first+2, pos.last-1], [pos.first-2, pos.last+1], [pos.first - 2, pos.last - 1], 
      [pos.first + 1, pos.last + 2], [pos.first + 1, pos.last - 2], [pos.first - 1, pos.last + 2], [pos.first - 1, pos.last - 2]]
      result.select { |pos| square_range.include?(pos[0]) && square_range.include?(pos[1]) }
  end 
  
  def new_move_positions(pos)
    remaining_moves = valid_moves(pos) - @visited_positions
    @visited_positions += remaining_moves
    remaining_moves
  end 
end 