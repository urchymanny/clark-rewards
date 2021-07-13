module Rewards
  class Generator
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def run
      customers = []
      customers_data = Extractor.new(data).extract
      customers_data.each do |customer_data|
        customer = Customer.new(customer_data)
        customers << customer
      end
      customers
    end

  end
end