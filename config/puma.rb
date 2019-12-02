# frozen_string_literal: true

require 'puma_worker_killer'

# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }
threads threads_count, threads_count

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
port ENV.fetch('PORT') { 3000 }

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch('RAILS_ENV') { 'development' }

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked webserver processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
workers ENV.fetch('WEB_CONCURRENCY') { 2 }

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
# preload_app!

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

APP_ROOT = File.expand_path('..', __dir__)
pidfile File.join(APP_ROOT, 'log/server.pid')
state_path File.join(APP_ROOT, 'log/server.state')

on_worker_boot do
  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!
end

after_worker_boot do
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end

# Puma worker killer
ram = (ENV['PUMA_WORKER_KILLER_RAM'] || 2048).to_i
percent_usage = (ENV['PUMA_WORKER_KILLER_PERCENT_USAGE'] || 0.98).to_f
frequency = (ENV['PUMA_WORKER_KILLER_FREQUENCY'] || 5).to_i
rolling_restart_freq = (ENV['PUMA_WORKER_KILLER_ROLLING_RESTART_FREQ'] || 2 * 3600).to_i

before_fork do
  PumaWorkerKiller.config do |config|
    config.ram = ram
    config.frequency = frequency
    config.percent_usage = percent_usage
    config.rolling_restart_frequency = rolling_restart_freq
  end
  PumaWorkerKiller.start if %w[development test].exclude?(Rails.env)
end
