require 'sidekiq'
require 'sidekiq-scheduler'

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6380/0' }

  config.on(:startup) do
    schedule_file = "config/sidekiq_scheduler.yml"
    if File.exist?(schedule_file)
      Sidekiq.schedule = YAML.load_file(schedule_file)
      Sidekiq::Scheduler.reload_schedule!
      puts "✅ Sidekiq schedule loaded from #{schedule_file}"
    else
      puts "⚠️  No Sidekiq schedule file found at #{schedule_file}"
    end
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6380/0' }
end
