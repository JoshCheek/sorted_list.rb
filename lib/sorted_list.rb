class SortedList
  class Node
    def initialize(comparer, data, next_node)
      raise unless comparer
      self.comparer  = comparer
      self.data      = data
      self.next_node = next_node
    end

    def add(data)
      if im_less_than? data
        self.next_node = next_node.add data
        self
      else
        Node.new comparer, data, self
      end
    end

    def remove(data)
      return next_node if data == self.data
      self.next_node = next_node.remove data
      self
    end

    def each(&block)
      block.call data
      next_node.each(&block)
    end

    protected

    attr_accessor :data, :next_node, :comparer

    def im_less_than?(data)
      comparer.call(self.data, data) <= 0
    end
  end
end

class SortedList
  class Node
    class Null
      def initialize(comparer)
        self.comparer = comparer
      end

      def each
      end

      def add(data)
        Node.new comparer, data, self
      end

      def remove(data)
        self
      end

      private

      attr_accessor :comparer
    end
  end
end

class SortedList
  include Enumerable

  def initialize(&comparer)
    self.comparer = comparer || default_comparer
    self.head = Node::Null.new self.comparer
  end

  def add(data)
    self.head = head.add data
  end

  def remove(data)
    self.head = head.remove data
  end

  def each(&block)
    head.each &block
  end

  protected

  def default_comparer
    lambda { |left, right| left <=> right }
  end

  attr_accessor :head, :comparer
end
