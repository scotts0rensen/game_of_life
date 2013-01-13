class Board

  attr_reader :size, :grid

  def initialize size=10
    @size = size
    @grid = Array.new(@size)
    @size.times do |x|
      @grid[x] = Array.new(@size)
      @size.times do |y|
        @grid[x][y] = false
      end
    end
  end

  def print_cell x,y
    if live? x,y 
      print "X"
    else
      print "O"
    end
  end

  def print_board
    @size.times do |x|
      print "|"
      @size.times do |y|
        print_cell x,y
        print "|"
      end
      print "\n"
    end
  end

  def live! x,y
    @grid[x][y] = true
    nil
  end

  def dead! x,y
    @grid[x][y] = false
    nil
  end

  def live? x,y
    @grid[x][y]
  end

  def live_cnt x,y
    if live? x,y
      1
    else
      0
    end
  end

  def live_neighbors x,y
    (live_cnt x-1, y-1)
      + (live_cnt x-1, y)
      + (live_cnt x-1, y+1)
      + (live_cnt x, y-1)
      + (live_cnt x, y+1)
      + (live_cnt x+1, y-1)
      + (live_cnt x+1, y)
      + (live_cnt x+1, y+1)
  end
end