class Board

  attr_reader :size, :grid

  def initialize size=10,board=nil
    @size = size
    @grid = Array.new(@size**2)
    @grid.map! { false }
    if !board.nil? && board.length == @grid.length
      false_vals = [nil,false,0,'0','o','O']
      board.map! { |a| !false_vals.include? a }
      @grid = board
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
    print "|"
    @grid.each_with_index do |val, index|
      print_cell x,y
      print "|"
      print "\n" if  (index+1) % size == 0
    end
    print "\n"
    nil
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
    
  def index x,y
    (x * size) + y
  end

  def set! x,y,val
    if valid_coord x,y
      @grid[index(x,y)] = val
    end
    nil
  end

  def live? x,y
    if valid_coord x,y
      @grid[index(x,y)]
    else
      false
    end
  end

  def dead? x,y
    !live? x,y
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
