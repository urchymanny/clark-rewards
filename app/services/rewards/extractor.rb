module Rewards
  class Extractor
    attr_reader :data
    
    TIME_SPREAD = 16

    def initialize(data)
      @data = data
    end

    def extract
      rows = data.split("\n").map
      customers = get_customers_data(rows)
      # divide data to rows and convert to array
      # get all customers from array
    end

    def get_customers_data(rows)
      customers_keys = []
      
      rows.each do |row|
        data_in_array = row.split(" ")
        if data_in_array.length > 3
          customers_keys << data_in_array[2]
          if data_in_array[3] == "recommends"
            customers_keys << data_in_array[4]
          end
        end
      end
      # find all customer's keys

      customers_keys.uniq! # remove duplicates
      customers_data = build_customer_data(customers_keys, rows)
    end

    def build_customer_data(customers_keys, rows)
      customers_data = []
      customers_keys.each do |key|
        customer_rows = rows.filter{ |s| s.include? key}
        actions = find_actions(customer_rows,key)
        customer_data = build_customer(key,actions)
        customers_data << customer_data
      end
      customers_data
      # get customer recommendation
      # get customer acceptance
      # prepare customer Hash
      # add to array of customers Hashes 
    end

    def build_customer(key, actions)
      customer = {}
      if actions[:recommendation_time].present?
        customer = { name: key, recommendation_time: actions[:recommendation_time], parent: actions[:parent]}
        if actions[:acceptance_time].present?
          customer[:accept] = true
          customer[:acceptance_time] = actions[:acceptance_time]
        end
      else
        customer = { 
          name: key,
          root: true,
         }
      end
      customer
      # prepare a customer's Hash which would be used to create a Customer instance for each customer
    end

    def find_actions(rows, key) #find recommendation and acceptance time
      actions = {key: key}
      rows.each do |row|
        row_items = row.split(" ")
        # find recommendation
        if row_items[3] == "recommends" && row_items[4] == key
          actions[:recommendation_time] ||= get_time(row)
          actions[:parent] ||= row_items[2]
        end

        if row_items[3] == "accepts"
          actions[:acceptance_time] ||= get_time(row)
        end
      end
      actions
    end

    def get_time(row)
      row.strip.first(TIME_SPREAD)
    end

    # def find_recommendation(rows,key)
    #   recommendation = {}
    #   rows.each do |row|
    #     if row.include? " #{key}"
    #       if row.split(" ").include?("recommends") && row.split(" ")[4] == key
    #         recommendation[:recommendation_time] = row.strip.first(TIME_SPREAD)
    #         recommendation[:parent] = row.split(" ")[2]
    #       end
    #     end
    #     break if recommendation.present? 
    #   end
    #   recommendation
    #   # return recommendation data(format: Hash)
    #   # TODO # save two recommendations to an array, sort with time & select first
    # end

    # def find_acceptance(rows, key)
    #   acceptance = {}
    #   rows.each do |row|
    #     if row.include? " #{key}"
    #       if row.include? "accepts"
    #         acceptance[:acceptance_time] = row.strip.first(TIME_SPREAD)
    #       end
    #     end
    #   end
    #   acceptance  
    #   # return acceptance data(format: Hash)
    # end

  end
end