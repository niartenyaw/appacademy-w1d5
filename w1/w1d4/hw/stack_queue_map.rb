class Stack
  def initialize
    @stack = []
  end

  def add(el)
    @stack.push(el)
  end

  def remove
    @stack.pop
  end

  def show
    @stack.to_s
  end
end

a = Stack.new
10.times do |i|
  a.add(i)
end

p a.show

4.times do
  puts a.remove
end

class Queue

  def initialize
    @queue = []
  end

  def enqueue(el)
    @queue.push(el)
  end

  def dequeue
    @queue.shift
  end

  def show
    @queue.to_s
  end
end

a = Queue.new
10.times do |i|
  a.enqueue(i)
end

p a.show

4.times do
  puts a.dequeue
end

class Map

  def initialize
    @map = []
  end

  def assign(key, value)
    idx = nil
    @map.each_index { |i| idx = i if @map[i][0] == key}
    if idx
      @map[idx] = [key, value]
    else
      @map << [key, value]
    end
  end

  def lookup(key)
    @map.each do |pair|
      return pair[1] if pair[0] == key
    end
    nil
  end

  def remove(key)
    @map.each_index do |i|
      if @map[i][0] == key
        @map.delete_at(i)
        break
      end
    end
  end

  def show
    @map.each do |pair|
      print "#{pair[0]} => #{pair[1]}\n"
    end
  end
end


a = Map.new
10.times do |i|
  a.assign(i.to_s, i)
end

a.show
puts

4.times do |i|
  a.assign(i.to_s, i.to_s * 2)
end

a.show
puts

4.times do |i|
  a.remove(i.to_s)
end

a.show
