def range(start_num, end_num)
  return [] if end_num < start_num
  return [end_num] if start_num == end_num
  [start_num] + range(start_num + 1, end_num)
end

def exp1(base, power)
  return 1 if power == 0
  base * exp1(base, power - 1)
end

def exp2(base, power)
  return 1 if power == 0
  half = exp2(base, power / 2)

  if power.even?
    half * half
  else
    base * half * half
  end
end

def child_net_worth_at_retire(parent_age)
  child_age_estimate = parent_age / 2
  child_bank_acct = child_age_estimate**2
  child_years_to_retire = 65 - child_age_estimate
  child_bank_acct * child_years_to_retire
end

class Array
  def deep_dup
    cur = []
    self.each do |el|
      cur << (el.is_a?(Array) ? el.deep_dup : el)
    end
    cur
  end
end

def fib(n)
  return [] if n < 1
  return [0] if n == 1
  return [0, 1] if n == 2

  prev_fib = fib(n - 1)
  prev_fib << prev_fib[-1] + prev_fib[-2]
end

def fib(n)
  return [] if n < 1
  return [0] if n == 1

  curr = [0, 1]

  curr << curr[-2] + curr[-1] until curr.length == n
end


class Array
  def subsets
    return [self] if self.length == 2
    set = [[]]
    self.each_index do |i|
      set << self
      set << [self[i]]
      remaining = self.select {|el| el != self[i]}
      set += remaining.subsets
    end
    set.uniq
  end
end

[1,2,3].subsets



class Array
  def subsets
    return [self] if empty?
    set = self[0..-2].subsets
    add_to_end = [last]
    set + (set.map { |arr| arr + add_to_end })
  end
end


class Array
  def permutations
    return [self] if self.length == 1
    set = []
    self.each_index do |i|
      curr_arr = self.dup
      curr_arr.delete_at(i)
      perm_without_num = curr_arr.permutations
      set += perm_without_num.map { |arr| [self[i]] + arr }
    end
    set
  end
end

[1,2,3].permutations


def bsearch(array, target)
  middle = array.length / 2
  return middle if array[middle] == target
  return nil if array.length <= 1

  if target > array[middle]
    bs = bsearch(array[middle..-1], target)
    bs.nil? ? bs : middle + bs
  else
    bsearch(array[0...middle], target)
  end
end


def merge_sort(array)
  ar_len = array.length
  return array if ar_len <= 1

  slice_amount = ar_len.even? ? ar_len / 2 : ar_len / 2 + 1
  set = []
  array.each_slice(slice_amount).map { |split| set << merge_sort(split) }

  merge(set)
end

def merge(set)
  sorted = []
  until set.flatten.empty?
    if set[0].empty?
      return sorted + set[1]
    end
    if set[1].empty?
      return sorted + set[0]
    end
    if set[0][0] > set[1][0]
      sorted << set[1].shift
    else
      sorted << set[0].shift
    end
  end
end

merge_sort([72,6,7,322,6,42,1,5,6])





def range(start_num, end_num)
  return [] if end_num < start_num
  return [start_num] if start_num == end_num

  [start_num] + range(start_num + 1, end_num)
end

def exp(base, power)
  return 1 if power == 0
  base * exp(base, power - 1)
end


def exp(base, power)
  return 1 if power == 0

  if power.even?
    square = exp(base, power / 2)
    square * square
  else
    square = exp(base, (power - 1) / 2)
    base * square * square
  end
end

class Array
  def deep_dup
    dup = []
    self.each do |el|
      if el.is_a?(Array)
        dup << el.deep_dup
      else
        dup << el
      end
    end
    dup
  end
end

def pascal(n)
  return [[1]] if n == 1
  prev = pascal(n - 1)
  last = prev.last
  set = [1]
  last.each_index do |i|
    next if i == last.length - 1
    set << last[i] + last[i + 1]
  end
  set.push(1)
  prev << set
end

pascal(1)
pascal(2)
pascal(4)


def greedy_make_change(amount, coins)
  return [] if amount == 0
  set = []

  until amount < coins.first
    set << coins.first
    amount -= coins.first
  end
  set + greedy_make_change(amount, coins[1..-1])
end

greedy_make_change(24,[25,10,5,1])

def make_better_change(amount, coins)
  return [] if amount == 0
  large = amount >= coins.first ? make_better_change(amount - coins.first, coins) : nil
  small = coins.length == 1 ? nil : make_better_change(amount, coins[1..-1])
  return nil if small.nil? && large.nil?
  return small if large.nil?
  large.unshift(coins.first)
  return large if small.nil?
  large.length <= small.length ? large : small
end


#[25, 25, 10, 1]
