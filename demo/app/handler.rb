require 'rugo'

module Handlers
  class Hello < Rugo::Handler
    def call(params)
      json 200, {Message: "Welcome User with id: #{user_id}!"}
    end
  end

  class User < Rugo::Handler
    def call(params)
      user_id = params[:id]
      json 200 , {Message: "Welcome User with id: #{user_id}!"}
    end
  end
end