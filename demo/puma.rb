# config/puma.rb

# Specifies the `environment` that Puma will run in.
environment ENV.fetch("RAILS_ENV") { "development" }

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
bind 'tcp://0.0.0.0:' + ENV.fetch("PORT") { '3000' }

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked web server processes.
# Workers are not used in development.
workers Integer(ENV['WEB_CONCURRENCY'] || 2)

# Specifies the number of `threads` that each worker
# will use. Default is 1-5.
threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
threads threads_count, threads_count

# Specifies the `preload_app!` directive which loads the application before forking workers
# preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

