module Earhart
  class Pattern
    def initialize(data)
      @struct = Scrawl.new(data)
    end

    def ===(other)
      Regexp.new(@struct.to_s) === other
    end

    def to_s
      "#{self.class.name}{#{@struct.inspect}}"
    end
  end
end
