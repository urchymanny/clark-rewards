RSpec.describe Rewards::Customer do
  describe "#initialize" do
    it "should create a customer" do
      customer_data = {
        parent: "Mba",
        name: "Uchenna",
        accept: true,
        recommendation_time: "2018-06-12 09:41",
        acceptance_time: "2018-06-14 09:41",
        points: 0.1,
      }
      customer = described_class.new(customer_data)
      expect(customer.key).to eq(customer_data[:name])
      expect(customer.parent).to eq(customer_data[:parent])
      expect(customer.accepted_contract).to eq(customer_data[:accept])
      expect(customer.acceptance_time).to eq(Time.zone.parse(customer_data[:acceptance_time]).to_s)
      expect(customer.recommendation_time).to eq(Time.zone.parse(customer_data[:recommendation_time]).to_s)
      expect(customer.points).to eq(customer_data[:points])
    end
  end
end