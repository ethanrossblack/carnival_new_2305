require "spec_helper"

describe "Ride" do

  context "Iteration 2" do

    before(:each) do
      @ride1 = Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle })
      @ride2 = Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle })
      @ride3 = Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling })

      @visitor1 = Visitor.new("Bruce", 54, "$10")
      @visitor2 = Visitor.new("Tucker", 36, "$5")
      @visitor3 = Visitor.new("Penny", 64, "$15")
    end

    it "exists and has attributes" do
      expect(@ride1).to be_a Ride
      expect(@ride1.name).to eq "Carousel"
      expect(@ride1.min_height).to eq 24
      expect(@ride1.admission_fee).to eq 1
      expect(@ride1.excitement).to eq :gentle
      expect(@ride1.total_revenue).to eq 0
      expect(@ride1.rider_log).to eq( {} )
    end

    describe "#board_rider" do

      before(:each) do
        @visitor1.add_preference(:gentle)
        @visitor2.add_preference(:gentle)

        @visitor2.add_preference(:thrilling)
        @visitor3.add_preference(:thrilling)
      end
      
      it "can track who has ridden the ride and how many times" do
        @ride1.board_rider(@visitor1)
        @ride1.board_rider(@visitor2)
        @ride1.board_rider(@visitor1)

        expect(@ride1.rider_log).to eq({@visitor1 => 2, @visitor2 => 1})
      end
      
      it "can reduce a rider's spending money by the admission fee" do
        expect(@visitor1.spending_money).to eq 10
        expect(@visitor2.spending_money).to eq 5
        expect(@ride1.admission_fee).to eq 1
        
        @ride1.board_rider(@visitor1)
        @ride1.board_rider(@visitor2)

        expect(@visitor1.spending_money).to eq 9
        expect(@visitor2.spending_money).to eq 4
        
        @ride1.board_rider(@visitor1)

        expect(@visitor1.spending_money).to eq 8
      end

      it "will only board riders who have enough spending money" do
        expect(@visitor1.spending_money).to eq 10
        expect(@ride1.admission_fee).to eq 1
        
        9.times {@ride1.board_rider(@visitor1)}
        
        expect(@visitor1.spending_money).to eq 1
        expect(@ride1.rider_log[@visitor1]).to eq 9
        
        @ride1.board_rider(@visitor1)
        
        expect(@visitor1.spending_money).to eq 0
        expect(@ride1.rider_log[@visitor1]).to eq 10
        
        @ride1.board_rider(@visitor1)
        
        expect(@visitor1.spending_money).to eq 0
        expect(@ride1.rider_log[@visitor1]).to eq 10
      end
      
      it "will only board riders who are tall enough" do
        expect(@ride3.min_height).to eq 54

        expect(@visitor2.height).to eq 36
        expect(@visitor3.height).to eq 64
        
        @ride3.board_rider(@visitor2)
        @ride3.board_rider(@visitor3)

        expect(@ride3.rider_log).to eq({ @visitor3 => 1 })
      end

      it "will only board riders who have a matching preference to the ride's excitement level" do
        expect(@ride1.excitement).to eq :gentle
        expect(@ride3.excitement).to eq :thrilling

        expect(@visitor1.preferences).to eq [:gentle]
        expect(@visitor3.preferences).to eq [:thrilling]

        @ride1.board_rider(@visitor1)
        @ride1.board_rider(@visitor3)

        expect(@ride1.rider_log).to eq({@visitor1 => 1})
        
        @ride3.board_rider(@visitor1)
        @ride3.board_rider(@visitor3)

        expect(@ride3.rider_log).to eq({@visitor3 => 1})
      end

      it "increases total revenue by ride's the admission fee" do
        expect(@ride1.admission_fee).to eq 1
        expect(@ride2.admission_fee).to eq 5
        expect(@ride3.admission_fee).to eq 2

        @ride1.board_rider(@visitor1)
        @ride1.board_rider(@visitor1)
        @ride1.board_rider(@visitor1)

        expect(@ride1.total_revenue).to eq 3

        @ride2.board_rider(@visitor2)

        expect(@ride2.total_revenue).to eq 5

        @ride3.board_rider(@visitor3)
        @ride3.board_rider(@visitor3)
        @ride3.board_rider(@visitor3)
        @ride3.board_rider(@visitor3)

        expect(@ride3.total_revenue).to eq 8
      end

    end

  end

end