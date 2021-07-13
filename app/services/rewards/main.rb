module Rewards
  class Main
    attr_reader :data

    def initialize(data)
        @data = data
    end

    def perform
      customers  = Generator.new(data).run     
    end    

  end
end