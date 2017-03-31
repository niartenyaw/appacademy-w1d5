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
