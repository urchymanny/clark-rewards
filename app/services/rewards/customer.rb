module Rewards
  class Customer
    # attr_reader :accept, :key, :recommendation_time, :acceptance_time, :parent,

    def initialize(customer_data)
      @key = customer_data[:name]
      @parent = customer_data[:parent]
      @accepted_contract = check_acceptance(customer_data[:accept])
      @recommendation_time =  parse_time(customer_data[:recommendation_time])
      @acceptance_time = parse_time(customer_data[:acceptance_time])
      @points = customer_data[:points]
      @root = customer_data[:root]
    end
    
    def check_acceptance(bool)
      if bool == true
        true
      else
        false
      end      
    end

    def parse_time(_time)
      begin
        parsed_time = Time.zone.parse(_time)
      rescue
        # raise problem with customer time
        ""
      else
        parsed_time.to_s
      end      
    end

  end
end