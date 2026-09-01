Rails.application.configure do
  config.litestream.replica_key_id     = Rails.application.credentials.dig(:litestream, :access_key_id)
  config.litestream.replica_access_key = Rails.application.credentials.dig(:litestream, :secret_access_key)
  config.litestream.username           = Rails.application.credentials.dig(:litestream, :username)
  config.litestream.password           = Rails.application.credentials.dig(:litestream, :password)
end
