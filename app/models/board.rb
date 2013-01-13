class Board

  attr_reader :size

  def initialize size=10,board=nil
    @size = size
    @grid = Array.new(@size**2)
    @grid.map! { false }
    if !board.nil? && board.length == @grid.length
      false_vals = [nil,false,0,'0','o','O']
      @grid = board.map { |a| !false_vals.include? a }
    end
  end

  def print_board
    @grid.each_with_index do |val, index|
      if (val)
        print "X"
      else
        print "O"
      end
      print "|"
      print "\n" if  (index+1) % size == 0
    end
    print "\n"
    nil
  end

  def index x,y
    (x * size) + y
  end

  def valid_coord? x,y
    i = index x,y
    i >= 0 && i < @grid.length
  end
    
  def live! x,y
    set! x,y,true
  end

  def dead! x,y
    set! x,y,false
  end

  def set! x,y,val
    if valid_coord? x,y
      @grid[index(x,y)] = val
    end
    val
  end

  def live? x,y
    if valid_coord? x,y
      @grid[index(x,y)]
    else
      false
    end
  end

  def dead? x,y
    !live? x,y
  end

  def live_neighbors_cnt x,y
    x_indexes = [x-1,x,x+1].select { |a| a >= 0 && a < @size }
    y_indexes = [y-1,y,y+1].select { |a| a >= 0 && a < @size }

    cnt = 0
    x_indexes.each do |x_index|
      y_indexes.each do |y_index|
        if !(x_index == x && y_index == y) && live?(x_index, y_index)
          cnt += 1
        end
      end
    end
    cnt
  end
end
