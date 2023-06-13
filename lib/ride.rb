class Ride
  attr_reader :name, :min_height, :admission_fee, :excitement, :total_revenue, :rider_log

  def initialize(attributes)
    @name = attributes[:name]
    @min_height = attributes[:min_height]
    @admission_fee = attributes[:admission_fee]
    @excitement = attributes[:excitement]
    @total_revenue = 0
    @rider_log = Hash.new(0)
  end

  def board_rider(rider)
    if rider.can_ride?(self)
      rider.spend_money(admission_fee)
      @total_revenue += admission_fee
      @rider_log[rider] += 1
    end
  end

  def total_rides
    0 if rider_log.empty?

    rider_log.sum { |_rider, rides| rides }
  end
end