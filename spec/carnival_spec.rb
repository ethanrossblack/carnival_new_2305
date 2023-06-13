require "spec_helper"

describe "Carnival" do
  before(:each) do
    @carnival = Carnival.new(14)

    @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
    @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
    @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })
  end

  context "Iteration 3: Basic Functionality" do
    describe "#initialize" do
      it "exists and has attributes" do
        expect(@carnival).to be_a Carnival
        expect(@carnival.duration).to eq 14
        expect(@carnival.rides).to eq []
      end
    end

    describe "#add_ride" do
      it "can add rides" do
        @carnival.add_ride(@ride1)

        expect(@carnival.rides).to eq [@ride1]
        
        @carnival.add_ride(@ride2)
        @carnival.add_ride(@ride3)

        expect(@carnival.rides).to eq [@ride1, @ride2, @ride3]
      end
    end
  end

  context "Iteration 3: Advanced Functionality" do
    before(:each) do
      @carnival.add_ride(@ride1)
      @carnival.add_ride(@ride2)
      @carnival.add_ride(@ride3)

      @visitor1 = Visitor.new("Bruce", 54, "$20")
      @visitor2 = Visitor.new("Tucker", 36, "$20")
      @visitor3 = Visitor.new("Penny", 64, "$18")

      @visitor1.add_preference(:gentle)
      @visitor2.add_preference(:gentle)
      @visitor2.add_preference(:thrilling)
      @visitor3.add_preference(:thrilling)

      15.times {@ride1.board_rider(@visitor1)}
      
      @ride2.board_rider(@visitor1)
      2.times { @ride2.board_rider(@visitor2) }

      10.times{ @ride3.board_rider(@visitor3) }
    end

    describe "#most_popular_ride" do
      it "returns the ride with the most total rides" do
        expect(@carnival.most_popular_ride).to eq @ride1
      end
    end

    describe "#most_profitable_ride" do
      it "returns the ride with the highest total revenue" do
        expect(@carnival.most_profitable_ride).to eq @ride3
      end
    end

    describe "#total_revenue" do
      it "returns the carnival's total revenue earned from all rides" do
        expect(@carnival.total_revenue).to eq 48
      end
    end
  end

end