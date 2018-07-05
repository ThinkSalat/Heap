require_relative 'heap_sort'

def k_largest_elements(array, k)
  # prc = proc  {|x,y| y <=> x}
  # heap = BinaryMinHeap.new(&prc)
  # array.each  { |el| heap.push(el)}
  # heap
  array.heap_sort!
  array[array.length-k...array.length]
end
