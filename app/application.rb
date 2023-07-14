require_relative 'handler'
require_relative 'rugo'

module App
  class Application < Rugo::RugoBase
    def routes
      [
        {method: 'GET', pattern: '/', handler: Handlers::Hello},
        {method: 'GET', pattern: '/hi', handler: Handlers::Hello},
        {method: 'GET', pattern: '/user/:id', handler: Handlers::User},
        {method: 'POST', pattern: '/ugg', handler: Handlers::Hello}
      ]
    end
  end
end
