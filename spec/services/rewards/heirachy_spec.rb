RSpec.describe Rewards::Heirachy do
  
  describe "#initialize" do
    it "should initialize class" do
      init = described_class.new(customers)
      expect(init).not_to be_nil
    end
  end

  describe ".get_root" do
    it "should find the root customer from the input" do
      root = described_class.new(customers).get_root
      expect(root.root).to be_truthy
    end
  end

  describe ".parent" do
    it "finds the parent of the last customer from the input" do
      parent = described_class.new(customers).parent(customers.last)
      expect(parent.key).to eq("C")
    end
  end

  describe ".points" do
    it "calculates a point using the level on the node tree" do
      level = 2.0
      points = described_class.new(customers).points(level)
      expect(points).to eq(0.25)
    end
  end

  describe ".inject_customer_to_tree" do
    it "should insert a customer into the heirachy tree" do
      heirachy = described_class.new(customers)
      insert = heirachy.inject_customer_to_tree(customers.first)
      expect(insert).to have_exactly(1).items
    end
  end

  describe ".reward_ancestors" do
    it "rewards ancestors of a node" do
      heirachy = described_class.new(customers)
      rewards = heirachy.reward_ancestors(customers.second)
      expect(rewards).to be_nil
      expect(heirachy.root_customer.points).to eq(1.0)
    end
  end

  describe ".reward_parents" do
    it "rewards parents of a child node" do
      heirachy = described_class.new(customers)
      reward = heirachy.reward_parents(customers.third, 0)
      expect(reward).to be_nil
      expect(heirachy.root_customer.points).to eq(0.5)
    end
  end

  let(:customers) {Rewards::Generator.new(complex_data).run}

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