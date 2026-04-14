Rails.application.config.middleware.use OmniAuth::Builder do
  google_oauth2 = Rails.application.config_for(:google_oauth2)

  provider :developer unless Rails.env.production?
  provider :google_oauth2, google_oauth2.client_id!, google_oauth2.client_secret!
end
