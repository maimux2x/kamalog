module MockAuthHelper
  def mock_auth(user)
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid:      user.uid,

      info: {
        name:  user.name,
        email: user.email
      }
    )

    yield
  ensure
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end
end
