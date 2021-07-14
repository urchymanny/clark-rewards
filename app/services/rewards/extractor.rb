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
    end

    #data extractor
    def get_customers_data(rows)
      customers_keys = []
      customers_data = []
      rows.each do |row|
        data_in_array = row.split(" ")
        if data_in_array.length > 3
          customers_keys << data_in_array[2]
          if data_in_array.include?("recommends")
            customers_keys << data_in_array[4]
          end
        end
      end

      customers_keys.uniq! # remove duplicates1

      # find other data relating to each customers_key
      customers_keys.each do |key|
        recommendation = find_recommendation(rows,key)
        acceptance = find_acceptance(rows, key)
        # check if recommendation already exists later****************
        customer_data = build_customer(key,recommendation,acceptance)
        customers_data << customer_data
      end
      customers_data
    end

    def build_customer(key, recommendation, acceptance)
      customer = {}
      if recommendation.present?
        customer = { name: key, recommendation_time: recommendation[:recommendation_time], parent: recommendation[:parent]}
        if acceptance.present?
          customer[:accept] = true
          customer[:acceptance_time] = acceptance[:acceptance_time]
        end
      else
        customer = { 
          name: key,
          root: true,
         }
      end
      customer
    end

    def find_recommendation(rows,key)
      recommendation = {}
      rows.each do |row|
        if row.include? " #{key}"
          if row.split(" ").include?("recommends") && row.split(" ")[4] == key
            recommendation[:recommendation_time] = row.strip.first(TIME_SPREAD)
            recommendation[:parent] = row.split(" ")[2]
          end
        end
        break if recommendation.present? #quit if first recommendation is found

        # save two recommendations to an array, sort with time & select first
      end
      recommendation
    end

    def find_acceptance(rows, key)
      acceptance = {}
      rows.each do |row|
        if row.include? " #{key}"
          if row.include? "accepts"
            acceptance[:acceptance_time] = row.strip.first(TIME_SPREAD)
          end
        end
      end
      acceptance  
    end

  end
end