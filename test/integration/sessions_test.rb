require 'test_helper'

class SessionsTest < ActionDispatch::IntegrationTest
  test 'create (After first login)' do
    assert_no_difference 'User.count' do
      mock_auth users(:alice) do
        get '/auth/google_oauth2/callback'
      end
    end

    assert_redirected_to welcome_path
  end
end
