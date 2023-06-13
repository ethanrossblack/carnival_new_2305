class Visitor
  attr_reader :name, :height, :spending_money, :preferences

  def initialize(name, height, spending_money)
    @name = name
    @height = height
    @spending_money = spending_money[1..].to_i
    @preferences = []
  end

  def add_preference(preference)
    @preferences << preference
  end

  def tall_enough?(height_threshold)
    height >= height_threshold
  end

  def enough_money?(cost)
    spending_money >= cost
  end

  def likes?(preference)
    preferences.include? preference
  end

  def spend_money(cost)
    if enough_money?(cost)
      @spending_money -= cost
    end
  end

  def can_ride?(ride)
    tall_enough?(ride.min_height) and 
    enough_money?(ride.admission_fee) and 
    likes?(ride.excitement)
  end

end