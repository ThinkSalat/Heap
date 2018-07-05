require 'byebug'
class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc ||= proc {|x,y| x <=> y}
  end

  def count
    @store.length
  end

  def extract
    val = @store[0]
    @store[0] = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, count)
    val
  end

  def peek
    @store[0]
  end

  def push(val)
    result = @store.push(val)
    BinaryMinHeap.heapify_up(@store, (count - 1), @prc)
    result
  end

  public
  def self.child_indices(len, parent_index)
    [(2 * parent_index + 1), (2 * parent_index + 2)].select { |el| el < len }
  end

  def self.parent_index(child_index)
    idx = (child_index - 1) / 2
    raise "root has no parent" if idx < 0
    idx
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= proc { |x,y| x <=> y }
    left, right = child_indices(len, parent_idx)
    parent = array[parent_idx]

    results =[]
    results << array[left] if left
    results << array[right] if right
  
    if results.all? { |child| prc.call(parent, child) <= 0 }
      return array
    end

    idx = nil
    if results.length == 1
      idx = left
    else
      idx = prc.call(results[0],results[1]) == -1 ?  left :  right
    end

    array[parent_idx], array[idx] = array[idx], parent
    
    heapify_down(array, idx, len, &prc)
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if child_idx == 0
    prc ||= proc {|x,y| x <=> y}
    parent_idx = parent_index(child_idx)
    parent = array[parent_idx]

    if prc.call(array[child_idx], parent) == -1 
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
    end
    heapify_up(array, parent_idx, len, &prc)
    array
  end
end
