class Carnival
  attr_reader :duration, :rides

  def initialize(duration)
    @duration = duration
    @rides = []
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

  def visitors
    rides.flat_map do |ride|
      ride.rider_log.keys
    end.uniq
  end

  def summary
    summary_hash = Hash.new

    summary_hash[:visitor_count] = visitors.count
    summary_hash[:revenue_earned] = total_revenue

    summary_hash
  end



end