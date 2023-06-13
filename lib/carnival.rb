class Carnival
  attr_reader :duration, :rides

  @@carnivals = []

  def initialize(duration)
    @duration = duration
    @rides = []

    @@carnivals << self
  end

  def add_ride(ride)
    @rides << ride
  end

  def most_popular_ride
    rides.max_by { |ride| ride.total_rides }
  end

  def most_profitable_ride
    rides.max_by { |ride| ride.total_revenue }
  end

  def total_revenue
    rides.sum { |ride| ride.total_revenue}
  end

  def self.total_revenues
    @@carnivals.sum { |carnival| carnival.total_revenue }
  end

  def self.carnivals
    @@carnivals
  end

  def visitors_array
    rides.flat_map do |ride|
      ride.rider_log.keys
    end.uniq
  end

  private def visitors_summary
    visitors_array.map do |visitor|
      visitor_details = {}
      visitor_details[:visitor] = visitor
      
      visitor_details[:favorite_ride] = rides.max_by do |ride|
        ride.rider_log[visitor]
      end

      visitor_details[:total_money_spent] = rides.sum do |ride|
        ride.rider_log[visitor] * ride.admission_fee
      end
      
      visitor_details
    end
  end

  private def rides_summary
    rides.map do |ride|
      ride_details = {}

      ride_details[:ride] = ride
      ride_details[:riders] = ride.rider_log.keys
      ride_details[:total_revenue] = ride.total_revenue

      ride_details
    end
  end

  def summary
    summary_hash = Hash.new

    summary_hash[:visitor_count] = visitors_summary.count
    summary_hash[:revenue_earned] = total_revenue
    summary_hash[:visitors] = visitors_summary
    summary_hash[:rides] = rides_summary

    summary_hash
  end

end