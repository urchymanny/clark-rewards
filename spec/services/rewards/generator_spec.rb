RSpec.describe Rewards::Generator do
  describe "#initialize" do
    it "should initialize class" do
      generator = described_class.new(complex_data)
      expect(generator).not_to be_nil
    end
  end

  describe ".run" do
    it "should generate customers using the data" do
      generator = described_class.new(complex_data)
      expect(generator.run).to be_an_instance_of(Array)
      expect(generator.run).to have_exactly(4).items
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
end