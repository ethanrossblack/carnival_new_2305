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

      9.times{ @ride3.board_rider(@visitor3) }
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

  context "Iteration 4" do
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

      9.times{ @ride3.board_rider(@visitor3) }
    end

    describe "#visitors_array" do
      it "returns an array containing each visitor" do
        expect(@carnival.visitors_array).to contain_exactly(@visitor1, @visitor2, @visitor3)
      end
    end

    describe "#summary" do
      before(:each) do
        @summary = @carnival.summary
      end

      it "can return a summary hash of the carnival" do
        expect(@summary).to be_a Hash
      end

      it "includes a visitor count" do
        expect(@summary[:visitor_count]).to eq 3
      end

      it "includes total revenue earned" do
        expect(@summary[:revenue_earned]).to eq 48
      end

      it "includes a list of visitors and each visitor's favorite ride and how much total money a visitor spent" do
        expected_visitors_summary = [
          {
            visitor: @visitor1,
            favorite_ride: @ride1,
            total_money_spent: 20
          },
          {
            visitor: @visitor2,
            favorite_ride: @ride2,
            total_money_spent: 10
          },
          {
            visitor: @visitor3,
            favorite_ride: @ride3,
            total_money_spent: 18
          }
        ]
        expect(@summary[:visitors]).to eq expected_visitors_summary
      end

      it "can return a list of rides and who rode each ride and the ride's total revenue" do
        expected_rides_summary = [
          {
            ride: @ride1,
            riders: [@visitor1],
            total_revenue: 15
          },
          {
            ride: @ride2,
            riders: [@visitor1, @visitor2],
            total_revenue: 15
          },
          {
            ride: @ride3,
            riders: [@visitor3],
            total_revenue: 18
          }
        ]

        expect(@summary[:rides]).to eq expected_rides_summary
      end
    end

  end
end