module Rugo
  class Router
    def initialize
      @routes = []
    end

    def match(method, route, handler)
      @routes << {method: method, pattern: Regexp.new("^#{route.gsub(/:[^\s\/]+/, '([A-Za-z0-9_]+)')}$"), handler: handler}
    end

    def execute(env)
      req = Rack::Request.new(env)
      method = req.request_method
      path = req.path_info
      @routes.each do |route|
        if route[:method] == method && (match = route[:pattern].match(path))
          params = match.captures
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

  private

  class HelloHandler
    def call(params)
      [200, { 'Content-Type' => 'text/html' }, ["<h1>Hello world!</h1>"]]
    end
  end
end
