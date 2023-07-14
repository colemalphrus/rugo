module Handlers
  class Hello
    def call(params)
      [200, { 'Content-Type' => 'text/html' }, ["<h1>hi!</h1>"]]
    end
  end

  class User
    def call(params)
      user_id = params[:id]
      [200, { 'Content-Type' => 'text/html' }, ["<h1>Welcome User with id: #{params}!</h1>"]]
    end
  end
end