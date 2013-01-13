class Game

  attr_reader :board

  def initialize size=10, board=nil
    @board= Board.new size, board
  end

  def run
    new_board = Board.new @board.size

    @board.size.times do |x|
      @board.size.times do |y|
        new_board.set!(x,y,tick(@board,x,y))
      end
    end

    @board = new_board
  end

  def tick board,x,y
    cnt = board.live_cnt x,y

    if board.dead?(x,y) && cnt == 3
      true
    elsif board.live?(x,y) && !(cnt == 2 || cnt == 3)
      false
    else
      board.live?(x,y)
    end
  end
end
