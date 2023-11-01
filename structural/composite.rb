class Component
  attr_accessor :parent

  def add(component)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def remove(component)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def composite?
    false
  end

  def perform
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class SubOperation < Component
  def perform
    "simple operation"
  end
end

class CompositeOperation < Component
  attr_accessor :children

  def initialize
    @children = []
  end

  def add(component)
    children << component
    component.parent = self
  end

  def composite?
    true
  end

  def perform
    results = []
    children.each { |child| results << child.perform }
    "Branch(#{results.join('+')})"
  end
end

sub_operation = SubOperation.new
composite_operation = CompositeOperation.new
difficult_task = CompositeOperation.new

composite_operation.add(sub_operation)
composite_operation.add(sub_operation)
difficult_task.add(composite_operation)
difficult_task.add(sub_operation)
difficult_task.perform
