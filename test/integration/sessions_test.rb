require 'test_helper'

class SessionsTest < ActionDispatch::IntegrationTest
  test 'create (After first login)' do
    assert_no_difference 'User.count' do
      mock_auth users(:alice) do
        get '/auth/google_oauth2/callback'
      end

      assert_response :see_other
    end

    assert_redirected_to studios_path
  end
end
