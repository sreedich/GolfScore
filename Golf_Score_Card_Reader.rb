require 'csv'

class HoleLayout
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

  def hole_layout_sum
    integer_swap.inject{|sum, num| sum + num}
  end
end



class ScoreCardReader
  attr_accessor :score_array
  
  def initialize
    @score_array = []
  end
  
  def players_score_card
      CSV.foreach("player_score_cards.csv") { |row| @score_array.push(row) }
      @score_array
  end

  def golf_hash
    hash = {}
    array1 = players_score_card
    array1.each do |n_array|
      num = n_array.slice(2..19)
      real_num = num.collect{|s| s.to_i}
      hash[n_array.slice(0..1)] = real_num
    end
    hash
  end

  def score_combiner
    b = HoleLayout.new
    golf_hash
    zip_hash = {}
    golf_hash.each do |key,value|
      zip_hash[key] = value.zip(b.integer_swap)
    end
    zip_hash
  end

  def final_score
    final_score_hash = {}
    score_combiner
    score_combiner.each do |key, value|
      final_score_hash[key] = value.map{|a,b| a - b}
    end
   final_score_hash
  end

  def par_comparison(score)
    case score
    when -4
      return "Condor"
    when -3
      return "Albatross"
    when -2
      return "Eagle"
    when -1
      return "Birdie"
    when 0
      return "Par"
    when 1
      return"Bogey"
    when 2
      return"Double Bogey"
    when 3
      return "Triple Bogey"
    end 
  end

  def total_score 
    total_hash = {}
    h = golf_hash
    h.each do |key, value|
      total_hash[key] = value.inject{|sum,num| sum + num}
    end 
    total_hash
  end 

  def name_array
    names = []
    score_combiner.each do |key,value|
      names.push(key)
    end
    names 
  end

  def strokes_array
    strokes = []
    golf_hash.each do |key,value|
      strokes.push(value)
    end
    strokes
  end

  def hole_score_array
    hole_score = []
    final_score.each do |key, value|
      hole_score.push(value)
    end 
    hole_score
  end

  def score_card(n)
    i = 0
    name = name_array[n]
    puts name
    18.times do 
    puts "Hole #{i+1}: #{strokes_array[n][i]} #{par_comparison(hole_score_array[n][i])}" 
      i +=1
    end
    puts "Total score: #{total_score[name]}"
    final_score = total_score[name] - 72
    final_score
  end

  def leader_board
    sorted_list = total_score.sort_by{ |k,v| v} 
    sorted_list.each do |key, value|
      puts "#{value} #{value -72} #{key}"
    end
  end
  
  def play
    score_card(0)
    score_card(1)
    score_card(2)
    score_card(3)
    score_card(4)
    leader_board
  end
end

m = ScoreCardReader.new
m.play

