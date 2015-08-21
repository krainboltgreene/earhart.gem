module Earhart
  class Router
    def initialize(resource: nil, headers: {}, routes: Earhart::Routes.new([]))
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

    def resource(resource:, headers: {})
      self.class.new(resource: resource, headers: headers, routes: @routes)
    end

    def lookup(request:)
      @routes.find(request.to_s).receiver
    end
  end
end
