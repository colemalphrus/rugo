require_relative 'router'

module App
  class Application
    def initialize
      @router = Router.new

      @router.match('GET', '/') do
        [200, { 'Content-Type' => 'text/html' }, ['<h1>Welcome to My Framework!</h1>']]
      end

      @router.match 'GET', '/hi' do [200, { 'Content-Type' => 'text/html' }, ["<h1>hi</h1>"]] end

      @router.match('GET','/user/:id') do |params|
        user_id = params[0]
        [200, { 'Content-Type' => 'text/html' }, ["<h1>Welcome User with id: #{user_id}!</h1>"]]
      end

      @router.match('POST','/ugg') do |params|
        [200, { 'Content-Type' => 'text/html' }, ["<h1>ugg!</h1>"]]
      end
    end

    def call(env)
      @router.execute(env)
    end
  end
end
