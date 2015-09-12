module Earhart
  module Null
    require_relative "null/match"
    require_relative "null/receiver"

    MATCH = Match.new
    RECEIVER = Receiver.new
  end
end
