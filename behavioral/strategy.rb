class TextFormatter
  def format(text)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class UppercaseFormatter < TextFormatter
  def format(text)
    text.upcase
  end
end

class LowercaseFormatter < TextFormatter
  def format(text)
    text.downcase
  end
end

# Context class that uses a strategy
class TextProcessor
  attr_accessor :formatter

  def initialize(formatter)
    @formatter = formatter
  end

  def process(text)
    formatter.format(text)
  end
end

text = "example text"

uppercase_formatter = UppercaseFormatter.new
lowercase_formatter = LowercaseFormatter.new

processor = TextProcessor.new(uppercase_formatter)
upper_case_result = processor.process(text)

processor.formatter = lowercase_formatter
lower_case_result = processor.process(text)
