Rails.application.configure do

  config.cache_classes = true

  config.eager_load = true

  config.consider_all_requests_local = false

  config.action_controller.perform_caching = true

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.assets.js_compressor = :uglifier

  config.assets.compile = true

  config.assets.digest = true

  config.log_level = :debug

  config.log_tags = [ :request_id ]

  config.action_mailer.default_url_options = { host: 'poke-connector.herokuapp.com' }
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default charset: "utf-8"
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                 587,
    domain:               'mail.google.com',
    user_name:            ENV['GOOGLE_USERNAME'],
    password:             ENV['GOOGLE_PASSWORD'],
    authentication:       'plain',
    enable_starttls_auto: true
  }

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false
end
