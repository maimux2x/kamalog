require 'test_helper'

class SessionsTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid:      '12345',

      info: {
        name:  'Alice',
        email: 'alice@example.com'
      }
    )
  end

  teardown do
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end

  test 'create (After first login)' do
    assert_no_difference 'User.count' do
      get '/auth/google_oauth2/callback'

      assert_response :see_other
    end

    assert_no_difference 'User.count' do
      get '/auth/google_oauth2/callback'

      assert_response :see_other
    end

    assert_redirected_to studios_path
  end
end
