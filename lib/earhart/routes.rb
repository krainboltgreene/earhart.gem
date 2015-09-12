module Earhart
  class Routes
    include Enumerable
    NULL_MATCH = Null::Match.new
    DEFAULT_COLLECTION = Hamster::EmptyHash

    def initialize
      @collection = DEFAULT_COLLECTION
    end

    def add(verb, resource, headers, receiver)
      @collection = @collection.put(Scrawl.new(verb: verb, resource: resource, headers: headers), receiver)
    end

    def find(verb, resource, headers)
      match(Scrawl.new(verb: verb, resource: resource, headers: headers).to_s)
    end

    def each(&block)
      @collection.each(&block)
    end

    private def match(query)
      string_match(query) || regexp_match(Regexp.new(query)) || Null::MATCH
    end

    private def string_match(query)
      collection.fetch(query.to_s)
    end

    private def regexp_match(query)
      collection.find { |pattern, receiver| pattern.match(query) }.last
    end

    private def collection
      @collection
    end
  end
end
