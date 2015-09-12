module Earhart
  class Router
    ID_PATTERN = "(?<id>.+)"
    PATH_DELIMITER = "/"
    DEFAULT_HEADERS = Hamster::EmptyHash

    def initialize
      @routes = Earhart::Routes.new

      yield(self) if block_given?
    end

    def collection(verb:, resource:, headers: DEFAULT_HEADERS, receiver:)
      routes.add(verb.upcase, collection_path(resource), headers, receiver)
    end

    def member(verb:, resource:, headers: DEFAULT_HEADERS, receiver:)
      routes.add(verb.upcase, member_path(resource), headers, receiver)
    end

    # def resource(resource:, headers: Hamster::EmptyHash)
    #   self.class.new(resource: resource, headers: headers, routes: @routes)
    # end

    def lookup(verb:, endpoint:, headers:)
      routes.find(verb, endpoint, headers).receiver
    end

    private def routes
      @routes
    end

    private def member_path(resource)
      collection_path(resource) + PATH_DELIMITER + ID_PATTERN
    end

    private def collection_path(resource)
      PATH_DELIMITER + resource.to_s
    end
  end
end
