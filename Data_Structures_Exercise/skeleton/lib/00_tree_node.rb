class PolyTreeNode
  attr_reader :children, :parent, :value
  
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end
  
  def parent=(parent_node)
    #if my parent is not nil, delete me from my parent's children 
    parent.children.delete(self) unless parent == nil 
    @parent = parent_node
    return parent if parent == nil
    unless parent.children.include?(self)
      parent.children << self
    end  
  end 
  
  def add_child(child_node)
    if child_node.class == PolyTreeNode
      children << child_node
      child_node.parent=(self)
    end  
  end 
  
  def remove_child(child_node)
    Raise "Not a child!" unless children.include?(child_node)
    child_node.parent=(nil)
    children.delete(child_node)
  end 
  
  def dfs(target_value)
    return self if target_value == self.value
    children.each do |child|
      search = child.dfs(target_value)
      return search unless search == nil   
    end 
    nil
  end 
  
  def bfs(target_value)
    queue = Queue.new
    queue.enq(self)
    until queue.empty?
      node = queue.deq
      return node if node.value == target_value
      node.children.each { |child| queue.enq(child) }
    end
    nil 
  end 
  
  # private 
  # attr_accessor :value, :parent, :children 
  
end