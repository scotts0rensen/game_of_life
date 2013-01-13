require 'spec_helper'

describe Board do
  it "has default size of 10" do
    Board.new.size.should eq 10
  end

  it "has ability to set live" do
    board = Board.new
    board.live!(2,2).should eq true
  end

  it "has ability to set dead" do
    board = Board.new
    board.dead!(2,2).should eq false
  end

  it "can retrieve live default value" do
    board = Board.new
    board.live?(2,2).should be false
  end

  context "should be dead for invalid arguments" do
    it "-1,-1" do
      board = Board.new
      board.live?(-1,-1).should be false
    end

    it "-1,0" do
      board = Board.new
      board.live?(-1,0).should be false
    end

    it "0,-1" do
      board = Board.new
      board.live?(0,-1).should be false
    end

    it "3,3" do
      board = Board.new 3
      board.live?(3,3).should be false
    end

    it "0,3" do
      board = Board.new 3
      board.live?(0,3).should be false
    end

    it "3,0" do
      board = Board.new 3
      board.live?(3,0).should be false
    end
  end

  it "can retrieve count of zero live neighbors" do
    board = Board.new
    board.live_cnt(2,2).should eq 0
  end

  it "can count 3 neighbors in the middle" do
    board = Board.new 3
    3.times do |x|
      3.times do |y|
        board.live! x,y
      end
    end

    board.live_cnt(1,1).should eq 8
  end

  it "can count 3 neighbors in a corner" do
    board = Board.new 3
    3.times do |x|
      3.times do |y|
        board.live! x,y
      end
    end

    board.live_cnt(0,2).should eq 3
  end

  it "can count 5 neighbors on a side" do
    board = Board.new 3
    3.times do |x|
      3.times do |y|
        board.live! x,y
      end
    end

    board.live_cnt(0,1).should eq 5
  end

  it "has ability to initialize with an array" do
    b = %w(x 0 0
           0 x 0
           0 0 x)
    board = Board.new 3,b
    board.live?(0,0).should be true
    board.live?(0,1).should be false
    board.live?(0,2).should be false
    board.live?(1,0).should be false
    board.live?(1,1).should be true
    board.live?(1,2).should be false
    board.live?(2,0).should be false
    board.live?(2,1).should be false
    board.live?(2,2).should be true
  end
end
