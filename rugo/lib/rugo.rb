require 'json'

module Rugo
  class Router
    def initialize
      @routes = []
    end

    def match(method, route, handler)
      regex = /(?<=\/:)\w+(?=\/|$)/
      # match = route.match(regex)
      match = route.scan(regex).flatten
      @routes << {
        method: method,
        pattern: Regexp.new("^#{route.gsub(/:[^\s\/]+/, '([A-Za-z0-9_]+)')}$"),
        handler: handler,
        path_params: match
      }
    end

    def execute(env)
      req = Rack::Request.new(env)
      method = req.request_method
      path = req.path_info
      query_params = req.params

      @routes.each do |route|
        if route[:method] == method && (match = route[:pattern].match(path))
          path_params = route[:path_params].zip(match.captures).to_h.transform_keys(&:to_sym)
          params = path_params.merge(query_params)
          return route[:handler].new.call(params)
        end
      end
      [404, { 'Content-Type' => 'text/html' }, ['<h1>Page not found</h1>']]
    end
  end

  class RugoBase
    def initialize
      @router = Router.new
      routes.each do |route|
        @router.match route[:method], route[:pattern], route[:handler]
      end
    end

    def call(env)
      @router.execute(env)
    end

    def routes
      [
        {method: 'GET', pattern: '/', handler: HelloHandler},
      ]
    end
  end

  class Handler
    private
    def json(status, body)
      [status, { 'Content-Type' => 'application/json' }, [body.to_json]]
    end
  end
  private

  class HelloHandler
    def call(params)
      [200, { 'Content-Type' => 'text/html' }, ["<h1>Welcome to Rugo!</h1>"]]
    end
  end
end
