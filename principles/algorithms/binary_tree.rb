class Node
  attr_reader :parent_id, :payload

  def initialize(parent_id, payload)
    @parent_id, @payload = parent_id, payload
  end
end

class Tree
  
end