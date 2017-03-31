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
