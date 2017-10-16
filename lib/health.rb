## Class to control health of player
class Health
  attr_accessor :max_health, :current_health
  def initialize(max_health, current_health = nil)
    @max_health = max_health.to_i
    @current_health = current_health
    @current_health = max_health.to_i if @current_health.nil?
  end

  def add(num_to_add)
    @current_health += num_to_add.to_i
    @current_health = @max_health if @current_health >= @max_health
    @current_health = 0 if @current_health < 0
  end

  def max
    @current_health = @max_health
  end
end
