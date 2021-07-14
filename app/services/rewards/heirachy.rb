module Rewards
  class Heirachy

    MAX_LEVEL = 2

    attr_accessor :root_customer, :tree, :customers

    def initialize(customers)
      @customers = customers
      @root_customer = get_root
      @tree = []
    end

    def get_root
      customers.select {|c| c.root == true}[0]
    end

    def reward_ancestors(customer)
      parent = parent(customer)
      parent_node = tree.select {|c| c == parent}
      parent_node ||= set_root_node(root_customer) #create root node if node has no parent
      inject_customer_to_tree(customer)
      reward_parents(customer, 0) if customer.accepted_contract
    end

    def set_root_node(customer)
      tree[:root] = customer      
    end

    def inject_customer_to_tree(customer)
      return customer if tree.include?(customer)
      tree << customer
    end

    def reward_parents(customer, level)
      return if level > MAX_LEVEL
      return unless customer.accepted_contract
      parent = parent(customer)
      parent.points += points(level)
      level += 1
      reward_parents(parent, level)
    end

    def points(level)
      (1.0/2.0)**level
    end

    def parent(customer)
      customers.select {|c| c.key == customer.parent}[0]
    end

  end
end