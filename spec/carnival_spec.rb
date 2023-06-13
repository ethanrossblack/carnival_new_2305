require "spec_helper"

describe "Carnival" do
  before(:each) do
    @carnival = Carnival.new(14)

    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })

    @visitor1 = Visitor.new("Bruce", 54, "$10")
    @visitor2 = Visitor.new("Tucker", 36, "$5")
    @visitor3 = Visitor.new("Penny", 64, "$15")
  end

  context "Iteration 3" do
    describe "#initialize" do
      it "exists and has attributes" do
        expect(@carnival).to be_a Carnival
        expect(@carnival.duration).to eq 14
        expect(@carnival.rides).to eq []
      end
    end

    describe "#add_ride" do
      it "can add rides" do
        @carvinal.add_ride(@ride1)

        expect(@carnival.rides).to eq [@ride1]
        
        @carvinal.add_ride(@ride2)
        @carvinal.add_ride(@ride3)

        expect(@carnival.rides).to eq [@ride1, @ride2, @ride3]
      end
    end
  end


end