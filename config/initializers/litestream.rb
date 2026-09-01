Rails.application.configure do
  return unless Rails.env.production?

  litestream = Rails.application.credentials.litestream

  config.litestream.access_key_id     = litestream.access_key_id
  config.litestream.secret_access_key = litestream.secret_access_key

  config.litestream.username = litestream.username
  config.litestream.password = litestream.password
end
