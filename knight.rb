require 'set'

module ConvertIndices
  def convertToOneD(x, y, width)
    x + y * width
  end

  def convertToTwoD(index, width)
    y = index/width 
    x = index - y * width
    [x, y] 
  end
end

class Knight
  include ConvertIndices

  def initialize
    @moves = get_moves
  end

  attr_reader :moves 

  def knight_moves(source, dest)
    s = convertToOneD(source[0], source[1], 8)
    d = convertToTwoD(dest[0], source[1], 8)


  end

  private 

  def get_moves #NOT RIGHT
    moves = Hash.new { |k, v| k[v] = Set.new }
    8.times do |x|
      7.times do |y|
        #check 6 possible "forward" moves from position x, y
        source = convertToOneD(x, y, 8)
        if (x + 1).between?(0, 7)
          if (y + 2).between?(0, 7)
            dest = convertToOneD(x + 1, y + 2, 8)
            moves[source] << dest
            moves[dest] << source
          end
          if (y - 2).between?(0, 7)
            dest = convertToOneD(x + 1, y - 2, 8)
            moves[source] << dest
            moves[dest] << source
          end
        end
      
        if (x + 2).between?(0, 7) 
          if (y + 1).between?(0, 7)
            dest = convertToOneD(x + 2, y + 1, 8)
            moves[source] << dest
            moves[dest] << source
          end
          if (y - 1).between?(0, 7)
            dest = convertToOneD(x + 2, y - 1, 8)
            moves[source] << dest
            moves[dest] << source
          end
        end

        if (x - 1).between?(0, 7) && (y + 2).between?(0, 7)
          dest = convertToOneD(x - 1, y + 2, 8)
          moves[source] << dest
          moves[dest] << source
        end

        if (x - 2).between?(0, 7) && (y + 1).between?(0, 7)
          dest = convertToOneD(x - 2, y + 1, 8)
          moves[source] << dest
          moves[dest] << source
        end
      end #end y loop
    end #end x loop
    moves
  end #end def
end

test = Knight.new

pp test.moves