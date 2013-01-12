class Board

  attr_reader :size

  def initialize
    @size = 10
    @grid = Array.new(@size)
    @size.times do |x|
      @grid[x] = Array.new(@size)
      @size.times do |y|
        @grid[x][y] = false
      end
    end
  end

  def live! x, y
    @grid[x][y] = true
    nil
  end

  def dead! x, y
    @grid[x][y] = false
    nil
  end

  def live? x, y
    @grid[x][y]
  end
end