def sum_to(num)
  return nil if num < 0
  return num if num <= 1
  num + sum_to(num - 1)
end

def add_numbers(arr)
  return arr[0] if arr.length <= 1
  arr[0] + add_numbers(arr[1..-1])
end

def gamma_fnc(num)
  factorial(num - 1)
end

def factorial(num)
  return nil if num < 0
  return 1 if num <= 1
  num * factorial(num - 1)
end

def ice_cream_shop(flavors, fav)
  return nil if flavors.empty?
  return flavors[0] == fav if flavors.length == 1
  flavors[0] == fav || ice_cream_shop(flavors[1..-1], fav)
end

def reverse(str)
  return str if str.length <= 1
  str[-1] + reverse(str[0..-2])
end

# MAX_STACK_SIZE = 200
# tracer = proc do |event|
#   if event == 'call' && caller_locations.length > MAX_STACK_SIZE
#     fail "Probable Stack Overflow"
#   end
# end
# set_trace_func(tracer)
#
# tracer.call(add_numbers([1,2,3,4]))


puts "sum_to"
puts sum_to(5) == 15
puts sum_to(1) == 1
puts sum_to(9) == 45
puts sum_to(-8) == nil

puts "add_numbers"
puts add_numbers([1,2,3,4]) == 10
puts add_numbers([3]) == 3
puts add_numbers([-80,34,7]) == -39
puts add_numbers([]) == nil

puts "gamma_fnc"
puts gamma_fnc(0) == nil
puts gamma_fnc(1) == 1
puts gamma_fnc(4) == 6
puts gamma_fnc(8) == 5040


puts "ice_cream_shop"
puts ice_cream_shop(['vanilla', 'strawberry'], 'blue moon') == false
puts ice_cream_shop(['pistachio', 'green tea', 'chocolate', 'mint chip'], 'green tea') == true
puts ice_cream_shop(['cookies n cream', 'blue moon', 'superman', 'honey lavender', 'sea salt caramel'], 'pistachio') == false
puts ice_cream_shop(['moose tracks'], 'moose tracks') == true
puts ice_cream_shop([], 'honey lavender') == false

puts "reverse"
puts reverse("house") == "esuoh"
puts reverse("dog") == "god"
puts reverse("atom") == "mota"
puts reverse("q") == "q"
puts reverse("id") == "di"
puts reverse("") == ""
