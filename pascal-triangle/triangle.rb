
class Triangle < Struct.new(:rows)
  def draw
    triangle(rows).each_with_index do |line, index|
      print ' ' * ((rows - index) * 2)
      line.each do |number|
        print number.to_s.ljust(4, ' ')
      end
      puts ''
    end
  end

  private

  def triangle(n)
    if n == 0
      [[1]]
    elsif n == 1
      triangle(n-1) + [[1, 1]]
    else
      previous = triangle(n - 1)
      center = previous.last.each_cons(2).map { |left, right| left + right }
      previous + [[1] + center + [1]]
    end
  end
end

Triangle.new(9).draw
