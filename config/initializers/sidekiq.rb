Sidekiq::Logging.logger = Rails.logger

# or

Sidekiq.configure_server do |config|
  config.logger = Rails.logger
end

Sidekiq.configure_client do |config|
  config.logger = Rails.logger
end