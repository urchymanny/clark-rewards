module Rewards
  class Main
    attr_reader :data, :customers, :response

    def initialize(data)
        @data = data
        @customers = Generator.new(data).run
        @response = {}
    end

    def perform
      customer_rewards = Rewarder.new(customers).perform
      customer_rewards.each do |customer|
        response[customer.key] = customer.points
      end
      response
    end
  end
end