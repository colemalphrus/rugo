module App
  class Router
    def initialize
      @routes = []
    end

    def match(method, route, &block)
      @routes << {method: method, pattern: Regexp.new("^#{route.gsub(/:[^\s\/]+/, '([A-Za-z0-9_]+)')}$"), block: block}
    end

    def execute(env)
      req = Rack::Request.new(env)
      method = req.request_method
      path = req.path_info
      @routes.each do |route|
        if route[:method] == method && (match = route[:pattern].match(path))
          params = match.captures
          return route[:block].call(params)
        end
      end
      [404, { 'Content-Type' => 'text/html' }, ['<h1>Page not found</h1>']]
    end
  end
end