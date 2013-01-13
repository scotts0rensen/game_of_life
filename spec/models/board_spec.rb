require 'spec_helper'

describe Board do
  it "has default size of 10" do
    Board.new.size.should eq 10
  end

  it "has ability to set live" do
    board = Board.new
    board.live!(2,2).should eq nil
  end

  it "has ability to set dead" do
    board = Board.new
    board.dead!(2,2).should eq nil
  end

  it "can retrieve live default value" do
    board = Board.new
    board.live?(2,2).should be false
  end

  it "can retrieve live changed value" do
    board = Board.new
    board.live!(2,2)
    board.live?(2,2).should be true
  end

  it "can retrieve count of zero live neighbors" do
    board = Board.new
    board.live_neighbors(2,2).should be 0
  end

  it "can retrieve count of all live neighbors" do
    #   0  1  2
    # 0 x  x  x
    # 1 x  ?  x
    # 2 x  x  x
    board = Board.new 3
    3.times do |x|
      3.times do |y|
        board.live! x,y
      end
    end

    board.print_board
    board.live_neighbors(1,1).should eq 9

  end
end
