module Earhart
  module Null
    class Route
      def receiver
        Null::Receiver.new
      end
    end
  end
end
