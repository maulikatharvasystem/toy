
require "spec_helper"
require './board'

describe Board::Play do
  describe '#initialize' do
    it 'returns originl positions' do
      a = {:x=>0, :y=>0, :f=>"North"}
      expect(Board::Play.new(a).get_values).to eq a
    end
  end

  describe ".move" do
  	it 'return valid positions for robot' do
  	 b = {:x=>0, :y=>1, :f=>"North"}
  	 hash_val = Board::Play.new({:x=>0, :y=>0, :f=>"North"}).move
  	 val = hash_val.inject({}){|convert,(k,v)| convert[k.to_sym] = v; convert}
  	 expect(val).to eq b
    end
  end

  describe ".left" do
  	it 'return valid positions for robot' do
  	 b = {:x=>0, :y=>1, :f=>"West"}
  	 hash_val = Board::Play.new({:x=>0, :y=>1, :f=>"North"}).left
  	 val = hash_val.inject({}){|convert,(k,v)| convert[k.to_sym] = v; convert}
  	 expect(val).to eq b
    end
  end

  describe ".right" do
  	it 'return valid positions for robot' do
  	 b = {:x=>0, :y=>1, :f=>"West"}
  	 hash_val = Board::Play.new({:x=>0, :y=>1, :f=>"South"}).right
  	 val = hash_val.inject({}){|convert,(k,v)| convert[k.to_sym] = v; convert}
  	 expect(val).to eq b
    end
  end


end