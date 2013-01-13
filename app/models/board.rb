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
    set! x,y,true
  end

  def dead! x,y
    set! x,y,false
  end

  def valid_coord x,y
    x >= 0 && x < @size && y >= 0 && y < @size
  end
    
  def set! x,y,val
    if valid_coord x,y
      @grid[x][y] = val
    end
    nil
  end

  def live? x,y
    if valid_coord x,y
      @grid[x][y]
    else
      false
    end
  end

  def live_cnt x,y
    cnt = 0
    cnt += 1 if live? x-1, y-1
    cnt += 1 if live? x-1, y
    cnt += 1 if live? x-1, y+1
    cnt += 1 if live? x, y-1
    cnt += 1 if live? x, y+1
    cnt += 1 if live? x+1, y-1
    cnt += 1 if live? x+1, y
    cnt += 1 if live? x+1, y+1
    cnt
  end
end