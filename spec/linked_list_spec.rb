require 'sorted_list'

# Defining contexts by just using a common phrase in the title because
# contexts are all run together at the end and I want to preserve the order

describe SortedList do
  let(:list) { SortedList.new }

  it 'can add data' do
    list.should_not include 1
    list.should_not include 2
    list.add 1
    list.add 2
    list.should include 1
    list.should include 2
  end

  it 'when removing data: does nothing when told to remove data it does not have' do
    list.remove 2
    list.should_not include 2
  end

  it 'when removing data: removes the first occurrence when it has duplicates' do
    list.add 1
    list.add 1
    list.remove 1
    list.should include 1
  end

  it 'when removing data: can remove the first piece of data' do
    list.add 2
    list.remove 2
    list.should_not include 2
  end

  it 'when removing data: can remove the last piece of data' do
    list.add 2
    list.add 1
    list.remove 2
    list.should include 1
    list.should_not include 2
  end

  it 'when removing data: can remove an intermediate piece of data' do
    list.add 3
    list.add 2
    list.add 1
    list.remove 2
    list.should include 1
    list.should_not include 2
    list.should include 3
  end

  it 'enumerable methods: iterates over nothing when has no data' do
    list.each { |data| raise 'this should never be invoked' }
  end

  it 'enumerable methods: defines #each' do
    list.add 1
    list.add 2
    ary = []
    list.each { |data| ary << data }
    ary.should == [1, 2]
  end

  # only checking map and to_a, but this represents that the Enumerable module is included
  it 'enumerable methods: can do any of the enumerable methods' do
    list.add 1
    list.add 2
    list.map { |data| data }.should == [1, 2]
    list.to_a.should == [1, 2]
  end

  it 'stores the data in a list of nodes linked to each other' do
    list.add 1
    list.add 2
    list.send(:head).send(:data).should == 1
    list.send(:head).send(:next_node).send(:data).should == 2
  end

  it 'stores the data sorted by <=> when not initialized with a block' do
    list.add 3
    list.add 1
    list.add 2
    list.to_a.should == [1, 2, 3]
  end

  it 'stores the data sorted by the block when initialized with a block' do
    list = SortedList.new { |left, right| right <=> left }
    list.add 3
    list.add 1
    list.add 2
    list.to_a.should == [3, 2, 1]
  end

  it 'can store multiples of the same data'
  it 'knows its size'
  it 'inspects to List(datum, datum, datum)'
  it 'List(datum, datum, datum) constructs a list of the data'
end
