module SignInHelper
  def sign_in_as(user)
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid:      user.uid,

      info: {
        name:  user.name,
        email: user.email
      }
    )

    visit root_path

    click_on 'Google アカウントでログイン'

    assert_current_path home_path
  end
end
