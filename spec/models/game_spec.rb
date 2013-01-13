require 'spec_helper'

describe Game do
  it "can create a board with default size of 10" do
    game = Game.new
    game.board.size.should eq 10
  end

  it "can create a board with size 100" do
    game = Game.new 100
    game.board.size.should eq 100
  end

  context "rule #1" do
    it "kills a live cell with 0 neighbors" do
      game = Game.new 3
      game.board.live! 1,1
      game.board.live_neighbors_cnt(1,1).should eq 0
      game.run
      game.board.live?(1,1).should eq false
    end
    it "kills a live cell with 1 neighbor" do
      game = Game.new 3
      game.board.live! 1,1
      game.board.live! 0,1
      game.board.live_neighbors_cnt(1,1).should eq 1
      game.run
      game.board.live?(1,1).should eq false
    end
  end

  context "rule #2" do
    it "keeps alive a live cell with 2 neighbors" do
      b = %w(0 1 0
             0 1 0
             0 1 0)
      game = Game.new 3,b
      game.board.live_neighbors_cnt(1,1).should eq 2
      game.run
      game.board.live?(1,1).should eq true
    end
    it "keeps alive a live cell with 3 neighbors" do
      b = %w(0 1 1 
             0 1 0
             0 1 0)
      game = Game.new 3, b
      game.board.live_neighbors_cnt(1,1).should eq 3
      game.run
      game.board.live?(1,1).should eq true
    end
  end

  context "rule #3" do
    it "kills a live cell with 4 neighbors" do
      b = %w(0 1 1
             1 1 0
             0 1 0)
      game = Game.new 3, b
      game.board.live_neighbors_cnt(1,1).should eq 4
      game.run
      game.board.live?(1,1).should eq false
    end
    it "kills a live cell with 5 neighbors" do
      b = %w(0 1 1
             1 1 0
             1 1 0)
      game = Game.new 3, b
      game.board.live_neighbors_cnt(1,1).should eq 5
      game.run
      game.board.live?(1,1).should eq false
    end
    it "kills a live cell with 6 neighbors" do
      b = %w(0 1 1
             1 1 1
             1 1 0)
      game = Game.new 3, b
      game.board.live_neighbors_cnt(1,1).should eq 6
      game.run
      game.board.live?(1,1).should eq false
    end
    it "kills a live cell with 7 neighbors" do
      b = %w(1 1 1
             1 1 1
             1 1 0)
      game = Game.new 3, b
      game.board.live_neighbors_cnt(1,1).should eq 7
      game.run
      game.board.live?(1,1).should eq false
    end
    it "killsneighbors_ a live cell with 8 neighbors" do
      b = %w(1 1 1
             1 1 1
             1 1 1)
      game = Game.new 3, b
      game.board.live_neighbors_cnt(1,1).should eq 8
      game.run
      game.board.live?(1,1).should eq false
    end
  end

  context "rule #4" do
    it "revives a dead cell with 3 neighbors" do
      b = %w(0 1 1
             1 1 1
             1 1 1)
      game = Game.new 3, b
      game.board.live_neighbors_cnt(0,0).should eq 3
      game.run
      game.board.live?(0,0).should eq true
    end
    it "should not revive a dead cell with 2 neighbors" do
      b = %w(0 0 1
             1 1 1
             1 1 1)
      game = Game.new 3, b
      game.board.live_neighbors_cnt(0,0).should eq 2
      game.run
      game.board.live?(0,0).should eq false
    end
  end

  it "should support the unchanging block" do
    b = %w(0 0 0 0 0
           0 x x 0 0
           0 x x 0 0
           0 0 0 0 0
           0 0 0 0 0)

    game = Game.new 5, b

    validate_board game.board, b
    game.run
    validate_board game.board, b
    game.run
    validate_board game.board, b
  end

  it "should support the unchanging beehive" do
    b = %w(0 0 0 0 0
           0 x x 0 0
           x 0 0 x 0
           0 x x 0 0
           0 0 0 0 0)

    game = Game.new 5, b

    validate_board game.board, b
    game.run
    validate_board game.board, b
    game.run
    validate_board game.board, b
  end

  it "should support the unchanging loaf" do
    b = %w(0 0 0 0 0
           0 x x 0 0
           x 0 0 x 0
           0 x 0 x 0
           0 0 x 0 0)

    game = Game.new 5, b

    validate_board game.board, b
    game.run
    validate_board game.board, b
    game.run
    validate_board game.board, b
  end

  it "should support the unchanging boat" do
    b = %w(0 0 0 0 0
           0 x x 0 0
           0 x 0 x 0
           0 0 x 0 0
           0 0 0 0 0)

    game = Game.new 5, b

    validate_board game.board, b
    game.run
    validate_board game.board, b
    game.run
    validate_board game.board, b
  end

  it "should support the oscillating line" do
    before = %w(0 0 0 0 0
                0 0 x 0 0
                0 0 x 0 0
                0 0 x 0 0
                0 0 0 0 0)

    after =  %w(0 0 0 0 0
                0 0 0 0 0
                0 x x x 0
                0 0 0 0 0
                0 0 0 0 0)

    game = Game.new 5, before

    validate_board game.board, before
    game.run
    validate_board game.board, after
    game.run
    validate_board game.board, before
  end

  it "should support the oscillating toad" do
    before = %w(0 0 0 0 0
                0 x x x 0
                x x x 0 0
                0 0 0 0 0
                0 0 0 0 0)

    after =  %w(0 0 x 0 0
                x 0 0 x 0
                x 0 0 x 0
                0 x 0 0 0
                0 0 0 0 0)

    game = Game.new 5, before

    validate_board game.board, before
    game.run
    validate_board game.board, after
    game.run
    validate_board game.board, before
  end

  def validate_board board, boardarr
    (board.size**2).should eq boardarr.length

    board.size.times do |x|
      board.size.times do |y|
        index = (x * board.size) + y
        board.live?(x,y).should eq true if boardarr[index] == "x"
        board.dead?(x,y).should eq true if boardarr[index] == "0"
      end
    end
  end
end
