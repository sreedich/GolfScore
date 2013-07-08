require 'csv'

class ScoreCard
  attr_accessor :array
  def initialize
    @array = []
  end

  def create_card
   CSV.foreach("hole_layout.csv") { |row| @array.push(row) }
   @array.flatten!
  end    

  def integer_swap
    create_card
    @array.collect{|s| s.to_i}
  end

  def num_sum
    integer_swap.inject{|sum, num| sum + num}
  end





end
