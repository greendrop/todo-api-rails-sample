# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.11.2'

set :application, 'todo-api-rails-sample'
set :repo_url, 'https://github.com/greendrop/todo-api-rails-sample.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, ENV['BRANCH'] || 'master'

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
set :deploy_to, "/home/ap/apps/#{fetch(:application)}"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"
append :linked_files, '.env'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'private'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

# rbenv
set :rbenv_type, :user
set :rbenv_path, '/home/ap/.rbenv'
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec" # rubocop:disable Metrics/LineLength
set :rbenv_map_bins, %w[rake gem bundle ruby rails]
set :rbenv_roles, :all

# nodenv
set :nodenv_type, :user
set :nodenv_node, File.read('.node-version').strip
set :nodenv_prefix, "NODENV_ROOT=#{fetch(:nodenv_path)} NODENV_VERSION=#{fetch(:nodenv_node)} #{fetch(:nodenv_path)}/bin/nodenv exec" # rubocop:disable Metrics/LineLength
set :nodenv_map_bins, %w[node npm yarn yarnpkg]
set :nodenv_roles, :all

# puma
set :puma_pid, "#{shared_path}/tmp/pids/server.pid"

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:hot_restart'
    end
  end

  after :publishing, :restart
end
