class Array
  def my_each(&prc)
    for i in (0...self.count)
      prc.call(self[i])
    end
    self
  end
end

class Array
  def my_select(&prc)
    results = []
    self.my_each do |el|
      results << el if prc.call(el)
    end
    results
  end
end

class Array
  def my_reject(&prc)
    results = []
    self.my_each do |el|
      results << el unless prc.call(el)
    end
    results
  end
end

class Array
  def my_any?(&prc)
    self.my_each do |el|
      return true if prc.call(el)
    end
    false
  end

  def my_all?(&prc)
    self.my_each do |el|
      return false unless prc.call(el)
    end
    true
  end
end

class Array
  def flat_arr(arr, results)
    arr.my_each do |el|
      if el.is_a?(Array)
        results = flat_arr(el, results)
      else
        results << el
      end
    end
    results
  end

  def my_flatten
    flat_arr(self, Array.new)
  end
end

class Array
  def my_zip(*args)
    results = []
    (0...self.count).to_a.my_each do |idx|
      curr = []
      curr << self[idx]
      args.my_each do |arg|
        curr << arg[idx]
      end
      results << curr
    end
    results
  end
end

class Array
  def my_rotate(num = 1)
    result = self.dup
    if num < 1
      num = self.length + num
    end
    num = num % self.length
    num.times do
      result << result.shift
    end
    result
  end
end

class Array
  def my_join(sep = "")
    result = ""
    (0...self.length).to_a.my_each do |i|
      if i == self.length - 1
        result << self[i]
      else
        result << self[i] << sep
      end
    end
    result
  end
end

class Array
  def my_reverse
    result = []
    self.my_each do |el|
      result.unshift(el)
    end
    result
  end
end


def factors(num)
  arr = []
  (1..num).to_a.my_each do |n|
    arr << n if num % n == 0
  end
  arr
end

class Array
  def bubble_sort!(&prc)
    (0...self.length).to_a.my_each do |el|
      switched = false
      (0...self.length - el).to_a.my_each do |j|
        if prc.call(self[j], self[j + 1]) == 1
          self[j], self[j + 1] = self[j + 1], self[j]
          switched = true
        end
      end
      break if switched == false
    end
    self
  end

  def bubble_sort(&prc)
    self.dup.bubble_sort!(&prc)
  end
end

def substrings(string)
  result = []
  (0...string.length).to_a.my_each do |i|
    (i...string.length).to_a.my_each do |j|
      result << string[i..j]
    end
  end
  result.uniq
end

def subwords(word, dictionary)
  subs = substrings(word)
  subs.my_select { |word| dictionary.include?(word) }
end

def doubler(array)
  array.map {|el| el * 2}
end


if __FILE__ == $PROGRAM_NAME
  # My Each
  return_value = [1, 2, 3].my_each do |num|
    puts num
  end.my_each do |num|
    puts num
  end

  # My Select
  a = [1, 2, 3]
  a.my_reject { |num| num > 1 } # => [1]
  a.my_reject { |num| num == 4 } # => [1, 2, 3]

  # My Any
  a = [1, 2, 3]
  a.my_any? { |num| num > 1 } # => true
  a.my_any? { |num| num == 4 } # => false
  a.my_all? { |num| num > 1 } # => false
  a.my_all? { |num| num < 4 } # => true

  # My Flatten
  [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

  # My Zip
  a = [ 4, 5, 6 ]
  b = [ 7, 8, 9 ]
  [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
  a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
  [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

  c = [10, 11, 12]
  d = [13, 14, 15]
  [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

  # My Rotate
  a = [ "a", "b", "c", "d" ]
  a.my_rotate         #=> ["b", "c", "d", "a"]
  a.my_rotate(2)      #=> ["c", "d", "a", "b"]
  a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
  a.my_rotate(15)     #=> ["d", "a", "b", "c"]

  # My Join
  a = [ "a", "b", "c", "d" ]
  a.my_join         # => "abcd"
  a.my_join("$")    # => "a$b$c$d"

  # Factor
  print "#{factors(4)}\n"
  print "#{factors(0)}\n"
  print "#{factors(10)}\n"

  puts "bubble_sort"
  print "#{[67,4,3,2,7,8].bubble_sort { |num1, num2| num1 <=> num2 }}\n"
  print "#{[8].bubble_sort { |num1, num2| num1 <=> num2 }}\n"

  puts "bubble_sort!"
  a = [67,4,3,2,7,8]
  print "#{a}\n"
  a.bubble_sort! { |num1, num2| num1 <=> num2 }
  print "#{a}\n"

  puts "substrings"
  puts substrings("cat")

  puts "subwords"
  dictionary = ["ca", "cat"]
  puts subwords("cat", dictionary)
end
