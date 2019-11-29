# frozen_string_literal: true

namespace :puma do
  def puma_execute(cmd)
    execute :sudo, :systemctl, cmd, "#{fetch(:application)}-puma"
  end

  desc 'Start puma server'
  task start: :environment do
    on roles(:app) do
      puma_execute(:start)
    end
  end

  desc 'Stop puma server'
  task stop: :environment do
    on roles(:app) do
      puma_execute(:stop)
    end
  end

  desc 'Restart puma server'
  task restart: :environment do
    on roles(:app) do
      if test("[ -f #{fetch(:puma_pid)} ]")
        puma_execute(:restart)
      else
        puma_execute(:start)
      end
    end
  end
end
