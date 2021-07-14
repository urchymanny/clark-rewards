module Rewards
  class Rewarder
    attr_reader :customers

    def initialize(customers)
      @customers = customers
    end

    def perform
      develop_customer_heirachy 
    end

    def develop_customer_heirachy
      customers.each do |customer|
        if customer.accepted_contract
          customer_tree.reward_ancestors(customer)
        else
          # customer_tree.create_reward_node(customer)
        end
      end
    end

    def customer_tree
      @customer_tree ||= Heirachy.new(customers)
    end
  end
end