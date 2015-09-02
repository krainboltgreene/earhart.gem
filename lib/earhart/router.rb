module Earhart
  class Router
    def initialize(resource: nil, headers: Hamster::EmptyHash, routes: Earhart::Routes.new(Hamster::EmptyList))
      @routes = routes
      @resource = resource
      @headers = headers

      yield(self) if block_given?
    end

    def collection(verb:, resource: @resource, headers: @headers, receiver:)
      @routes.add(Pattern.new(verb: verb.upcase, resource: %r|/#{resource}/?|, headers: headers), receiver)
    end

    def member(verb:, resource: @resource, headers: @headers, receiver:)
      @routes.add(Pattern.new(verb: verb.upcase, resource: %r|/#{resource}/(?<id>.+)/?|, headers: headers), receiver)
    end

    def resource(resource:, headers: Hamster::EmptyHash)
      self.class.new(resource: resource, headers: headers, routes: @routes)
    end

    def lookup(request:)
      @routes.find(request.to_s).receiver
    end
  end
end
