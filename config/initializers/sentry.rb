# frozen_string_literal: true

Sentry.init do |config|
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]
  config.dsn = 'https://65ab4e299e359427980ab68d2e0c1407@o4512021564096512.ingest.us.sentry.io/4512021573992448'
  config.traces_sample_rate = 1.0
end
