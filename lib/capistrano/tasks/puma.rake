# frozen_string_literal: true

namespace :puma do
  def puma_execute(cmd)
    execute :sudo, :systemctl, cmd, "#{fetch(:application)}-puma"
  end

  desc 'Start puma server'
  task :start do
    on roles(:app) do
      puma_execute(:start)
    end
  end

  desc 'Stop puma server'
  task :stop do
    on roles(:app) do
      puma_execute(:stop)
    end
  end

  desc 'Restart puma server'
  task :restart do
    on roles(:app) do
      if test("[ -f #{fetch(:puma_pid_path)} ]")
        execute :sudo, :kill, "-s SIGUSR1 `cat #{fetch(:puma_pid_path)}`"
      else
        puma_execute(:start)
      end
    end
  end
end
