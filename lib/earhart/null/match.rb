module Earhart
  module Null
    class Match < BasicObject
      def last
        Null::RECEIVER
      end
    end
  end
end
