require 'rspec'
require 'csv'
require_relative 'Golf_Score_Card_Reader.rb'

describe HoleLayout do 

  let(:card){      
    HoleLayout.new  
  }                
                   
  let(:reader){
    ScoreCardReader.new
  } 

  it 'Instance pulls in a csv file called score.csv and puts it in an array called card' do
    expect(card.create_card.size).to eql(18)
  end

  it 'Array items should be integers' do
    expect(card.integer_swap[0].is_a? Integer).to eql(true)
    expect(card.integer_swap[2].is_a? Integer).to eql(true)
    expect(card.integer_swap[4].is_a? Integer).to eql(true)
    expect(card.integer_swap[6].is_a? Integer).to eql(true)
  end

  it 'Total should equal to 72' do
    expect(card.hole_layout_sum).to eql(72)
  end 
    
  it 'Grabs the players score cards(csv)' do
    expect(reader.players_score_card[0][0]).to eql('Woods')
    expect(reader.players_score_card[0][1]).to eql(' Tiger')
  end
  
  it 'puts players score and names in a hash' do
    hash = reader.golf_hash
    expect(hash.has_key?(["Woods", " Tiger"])).to eql(true)
    expect(hash.has_key?(["Fajobi", " Jide"])).to eql(true)
    expect(hash.has_key?(["Reedich", " Steve"])).to eql(true)
    expect(hash.has_key?(["Watson", " Bubba"])).to eql(true)
    expect(hash.has_key?(["Zopf", " Jason"])).to eql(true)
  end
  
  it 'combines the players scores' do 
    hash = reader.score_combiner
    expect(hash[["Woods", " Tiger"]].count).to eql(18)
    expect(hash[["Fajobi", " Jide"]].count).to eql(18)
    expect(hash[["Reedich", " Steve"]].count).to eql(18)
    expect(hash[["Watson", " Bubba"]].count).to eql(18)
    expect(hash[["Zopf", " Jason"]].count).to eql(18)
  end

  it 'returns players final score per hole in a hash' do
    hash = reader.final_score
    expect(hash[["Woods", " Tiger"]].count).to eql(18)
  end

  it 'returns player stroke to par comparison' do
    expect(reader.par_comparison(-2)).to eql("Eagle")
    expect(reader.par_comparison(-3)).to eql("Albatross")
    expect(reader.par_comparison(0)).to eql("Par")
    expect(reader.par_comparison(-1)).to eql("Birdie")
  end

  it 'returns players total score' do
    hash = reader.total_score
    expect(hash[["Woods", " Tiger"]]).to eql(51)
  end

  it 'prints out each players name' do  
    expect(reader.name_array[0]).to eql(["Woods", " Tiger"])
    expect(reader.name_array[1]).to eql(["Watson", " Bubba"])
  end

  it 'prints out the player stroke' do
    expect(reader.strokes_array[0].count).to eql(18)
    expect(reader.strokes_array[0][0].is_a? Integer).to eql(true)
  end

  it 'prints out players hole score' do
    expect(reader.hole_score_array.count).to eql(5)
    expect(reader.hole_score_array[0][0].is_a? Integer).to eql(true)
  end

  it 'prints out players score card' do 
    expect(reader.score_card(4)).to eql(-35)
  end
  
end
