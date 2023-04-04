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

module Path
  def shortest_path(num_verts, graph, source, dest)
    dist = Array.new(num_verts, -1)
    prev = Array.new(num_verts)

    dist[source] = 0
    queue = [source]

    until queue.empty?
      u = queue.shift

      moves[u].each do |elem| 
        if dist[elem] == -1
          queue << elem
          dist[elem] = dist[u] + 1
          prev[elem] = u

          if elem == dest
            return reconstruct_path(source, dest, prev)
          end
        end 
      end 
    end 
    reconstruct_path(source, dest, prev)
  end 

  def reconstruct_path(source, dest, prev)
    path = []
    return path if prev[dest].nil? #destination is unreachable
    until source == dest
      path << dest
      dest = prev[dest]
    end
    path << source 
    path.reverse 
  end

  def report_path(path)
    if path.length == 0
      puts "You didn't make it :("
      return 
    end

    report = path.length - 1 == 1 ? "move" : "moves"
    puts "You made it in #{path.length - 1} #{report}! Here is your path:" 
    path.each { |elem| pp elem }
  end
end

class Knight
  include ConvertIndices
  include Path

  def initialize
    @moves = get_moves
  end

  attr_reader :moves 

  def knight_moves(source, dest)
    s = convertToOneD(source[0], source[1], 8)

    d = convertToOneD(dest[0], dest[1], 8)

    path = shortest_path(64, moves, s, d)

    path = path.map { |elem| convertToTwoD(elem, 8) }

    report_path(path)
  end

  private 

  def get_moves 
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
      end 
    end 
    moves
  end 
end

test = Knight.new

pp test.moves

test.knight_moves([0, 0], [2, 1])

test.knight_moves([0, 0], [3, 3])

test.knight_moves([0, 0], [7, 7])