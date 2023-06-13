require "spec_helper"

describe "Visitor" do

  before (:each) do
    @visitor1 = Visitor.new("Bruce", 54, "$10")
    @visitor2 = Visitor.new("Tucker", 36, "$5")
    @visitor3 = Visitor.new("Penny", 64, "$15")
  end
  
  context "Iteration 1" do

    describe "#initialize" do
      it "exists and has attributes" do
        expect(@visitor1).to be_a Visitor
        expect(@visitor1.name).to eq "Bruce"
        expect(@visitor1.height).to eq 54
        expect(@visitor1.spending_money).to eq 10
      end
      
      it "starts with no preferences" do
        expect(@visitor1.preferences).to eq([])
      end
    end
    
    describe "#add_preference" do
      it "can add preferences" do
        @visitor1.add_preference(:gentle)
        @visitor1.add_preference(:thrilling)

        expect(@visitor1.preferences).to eq([:gentle, :thrilling])
        expect(@visitor2.preferences).to eq([])
        expect(@visitor3.preferences).to eq([])
      end
    end

    describe "#tall_enough?" do
      it "can tell if a visitor is tall enough for a ride based on a given height threshold" do
        expect(@visitor1.tall_enough?(54)).to be true
        expect(@visitor2.tall_enough?(54)).to be false
        expect(@visitor3.tall_enough?(54)).to be true
        expect(@visitor1.tall_enough?(64)).to be false
      end
    end

  end

  context "iteration 2" do

    describe "#enough_money?" do
      it "returns if a visitor has enough money to spend on something" do
        expect(@visitor1.enough_money?(5)).to be true
        expect(@visitor1.enough_money?(10)).to be true
        expect(@visitor1.enough_money?(11)).to be false
      end
    end

    describe "#likes?" do
      it "returns if a visitor likes something based on their preferences" do
        expect(@visitor1.likes?(:excitement)).to be false
        
        @visitor1.add_preference(:excitement)
        
        expect(@visitor1.likes?(:excitement)).to be true
      end
    end

    describe "#spend_money" do
      it "can spend money" do
        @visitor1.spend_money(5)
        
        expect(@visitor1.spending_money).to eq 5

        @visitor1.spend_money(5)
        
        expect(@visitor1.spending_money).to eq 0
      end
      
      it "will not go into debt to spend money it doesn't have" do
        expect(@visitor1.spending_money).to eq 10

        @visitor1.spend_money(100000)
        
        expect(@visitor1.spending_money).to eq 10
      end
    end

    describe "#can_ride?" do

      it "can tell if a rider is elligible to ride a ride" do
        ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
        ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
        ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
        ride4 = Ride.new({ name: 'Expensive Carousel', min_height: 24, admission_fee: 1000, excitement: :gentle })

        visitor4 = Visitor.new("Richy Rich", 70, "$100000000")

        @visitor1.add_preference(:gentle)
        @visitor2.add_preference(:gentle)
        @visitor2.add_preference(:thrilling)
        @visitor3.add_preference(:thrilling)
        visitor4.add_preference(:gentle)
        visitor4.add_preference(:thrilling)

        expect(@visitor1.can_ride?(ride1)).to be true
        expect(@visitor1.can_ride?(ride2)).to be true
        expect(@visitor1.can_ride?(ride3)).to be false
        expect(@visitor1.can_ride?(ride4)).to be false

        expect(@visitor2.can_ride?(ride1)).to be true
        expect(@visitor2.can_ride?(ride2)).to be true
        expect(@visitor2.can_ride?(ride3)).to be false
        expect(@visitor2.can_ride?(ride4)).to eq false

        expect(@visitor3.can_ride?(ride1)).to eq false
        expect(@visitor3.can_ride?(ride2)).to eq false
        expect(@visitor3.can_ride?(ride3)).to eq true
        expect(@visitor3.can_ride?(ride4)).to eq false

        expect(visitor4.can_ride?(ride1)).to eq true
        expect(visitor4.can_ride?(ride2)).to eq true
        expect(visitor4.can_ride?(ride3)).to eq true
        expect(visitor4.can_ride?(ride4)).to eq true
      end

    end

  end
end