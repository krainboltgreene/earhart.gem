module Earhart
  class Pattern
    def initialize(data)
      @struct = Scrawl.new(data)
    end

    def ===(other)
      Regexp.new(@struct.inspect) === other
    end
  end
end
