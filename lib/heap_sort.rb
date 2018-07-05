require_relative "heap"

class Array
  def heap_sort!
    sorted = true
    reduce do |acc, el|
      sorted = false if acc > el
      el
    end
    return self if sorted
    heap = BinaryMinHeap.new
    each { |el| heap.push(el)}
    sorted_array = []
    length.times do |i|
      self[i] = heap.extract
    end
  end
end
