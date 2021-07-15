RSpec.describe Rewards::Extractor do

    describe "#initialize" do
      it "should initialize class" do
        ex = described_class.new(complex_data)
        expect(ex).not_to be_nil
      end
    end

    describe ".extract" do
      it "should extract the data" do
        expect(extractor.extract).to be_an_instance_of(Array)
        expect(extractor.extract).not_to be_nil
      end
    end

    describe ".get_customers_data" do
      it "gets cusomters data from an input row" do
        customer_data = extractor.get_customers_data(row)
        expect(customer_data).to eq([
          {:name=>"A", :root=>true}, 
          {:name=>"B", :parent=>"A", :recommendation_time=>"2018-06-12 09:41"}])
      end
    end
    
    describe ".build_customer" do
      it "should construct a customer object" do
        customer = extractor.build_customer(
          "B", 
          {parent: "A", recommendation_time: "2018-06-12 09:41"}, 
          {acceptance_time: "2018-06-14 09:41"})
        expect(customer).to eq({ 
            :accept=>true, 
            :acceptance_time=>"2018-06-14 09:41", 
            :name=>"B", 
            :parent=>"A", 
            :recommendation_time=>"2018-06-12 09:41"})
      end
    end

    describe ".find_recommendation" do
      it "extracts recommender and time from input" do
       rows = [
         "2018-06-12 09:41 A recommends B",
         "2018-06-14 09:41 B accepts"
       ]
       recommendation = extractor.find_recommendation(rows, "B")
       expect(recommendation).to eq({
         :parent=>"A", 
         :recommendation_time=>"2018-06-12 09:41"})
      end
    end

    describe ".find_acceptance" do
      it "extracts acceptance time from input" do
       rows = [
         "2018-06-12 09:41 A recommends B",
         "2018-06-14 09:41 B accepts"
       ]
       acceptance = extractor.find_acceptance(rows, "B")
       expect(acceptance).to eq({:acceptance_time=>"2018-06-14 09:41"})
      end
    end


    let(:complex_data) do
      <<-CUSTOMERS
        2018-06-12 09:41 A recommends B
        2018-06-14 09:41 B accepts
        2018-06-16 09:41 B recommends C
        2018-06-17 09:41 C accepts
        2018-06-19 09:41 C recommends D
        2018-06-23 09:41 B recommends D
        2018-06-25 09:41 D accepts
      CUSTOMERS
    end

    let(:simple_data) do
      <<-CUSTOMERS
        2018-06-12 09:41 A recommends B
        2018-06-14 09:41 B accepts
      CUSTOMERS
    end

    let(:extractor) {described_class.new(complex_data)}
    let (:row) {["2018-06-12 09:41 A recommends B"]}
end