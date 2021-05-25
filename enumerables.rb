require 'byebug'

class Array
  def my_each(&prc)
    i = 0
    while i < length
      prc.call(self[i])
      i += 1
    end

    self
  end

  def my_select(&prc)
    output = []
    my_each { |el| output << el if prc.call(el) }
    output
  end

  def my_reject(&prc)
    output = []
    my_each { |el| output << el unless prc.call(el) }
    output
  end

  def my_any?(&prc)
    my_each { |el| return true if prc.call(el) }
    false
  end

  def my_all?(&prc)
    my_each { |el| return false unless prc.call(el) }
    true
  end

  def my_flatten
    return self if my_all? { |el| !el.is_a?(Array) }

    array = []
    each do |el|
      if el.is_a?(Array)
        array.concat(el.my_flatten)
      else
        array << el
      end
    end
    array
  end

  def my_zip(*args)
    zip = Array.new(self.length) { Array.new(args.length + 1, nil) }

    # debugger
    self.each_with_index do |ele, idx|
       zip[idx][0] = ele
    end

    (0...zip.length).each do |idx1|       # 0, 1
      (1...zip[0].length).each do |idx2|  # 1, 2
        zip[idx1][idx2] = args[idx2 - 1][idx1]
      end
    end

    zip
  end

  def my_rotate(n = 1)
    if n > 0
      self.map.with_index { |ele, idx| self[(idx + n) % self.length] }
    else
      self.map.with_index { |ele, idx| self[(idx - n.abs) % self.length] }
    end
    
  end

  def my_join(str = "")
    joined = ""

    self.each_with_index do |ele, idx|
      if idx == self.length - 1
        joined += ele
      else
        joined += (ele + str)
      end
    end
    
    joined
  end
  
  def my_reverse
    reversed = []

    (self.length - 1).downto(0).each do |idx|
      reversed << self[idx]
    end

    reversed
  end
end

# p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
# p [ 1 ].my_reverse               #=> [1]

# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"

# a = [ "a", "b", "c", "d" ]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(3)      #=> 
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

# a = [ 4, 5, 6 ] #[0,0][0,1] >> [0,1][1,1]
# b = [ 7, 8, 9 ] #[1,0][1,1] >> [0,2][1,2]
# p [1, 2, 3].my_zip(a, b) == [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   == [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    == [[1, 4, 7], [2, 5, 8]] 

# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    == [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

#  # calls my_each twice on the array, printing all the numbers twice.
# return_value = [1, 2, 3].my_each do |num|
#   puts num
# end

# return_value.my_each do |num|
#   puts num
# end
# # # => 1
# #      2
# #      3
# #      1
# #      2
# #      3

# p return_value  # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []

# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_any? { |num| num > 1 } # => true
# p a.my_any? { |num| num == 4 } # => false
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

