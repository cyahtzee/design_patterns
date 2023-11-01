class ApiInterface1
  def fast_perform
    "fast perform"
  end
end

class ApiInterface2
  def slow_perform
    "slow perform"
  end
end

class Adapter
  attr_reader :interface

  def initialize(interface)
    @interface = interface
  end
end

class ApiAdapter1 < Adapter
  def perform
    interface.fast_perform
  end
end

class ApiAdapter2 < Adapter
  def perform
    interface.slow_perform
  end
end

class MyApplication
  attr_reader :adapter

  def initialize
    @adapters = []
  end

  def perform
    adapters.map(&:perform)
  end

  def add(adapter)
    adapters << adapter
  end
end

my_application = MyApplication.new
adapter_one = ApiAdapter1.new(ApiInterface1.new)
adapter_two = ApiAdapter2.new(ApiInterface2.new)
my_application.add(adapter_one)
my_application.add(adapter_two)
my_application.perform
