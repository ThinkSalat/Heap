require_relative "heap"

class Array
  def heap_sort!

    # check if array is sorted already
    sorted = true
    reduce do |acc, el|
      sorted = false if acc > el
      el
    end

    # Don't sort if it's already sorted
    return self if sorted

    # create new heap from array, then extract into ascending arr indices
    heap = BinaryMinHeap.new
    each { |el| heap.push(el)}
    length.times do |i|
      self[i] = heap.extract
    end
  end
end
