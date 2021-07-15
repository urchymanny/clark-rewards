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
        end
      end
      # create customer tree and reward them accordingly
    end

    def customer_tree
      @customer_tree ||= Heirachy.new(customers)
      # make sure customer tree is not reset if it exists already
    end
  end
end