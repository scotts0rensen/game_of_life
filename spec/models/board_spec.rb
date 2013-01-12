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
end
