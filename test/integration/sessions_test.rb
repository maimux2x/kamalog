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

  test 'create (First login)' do
    User.destroy_all

    assert_difference 'User.count', 1 do
      get '/auth/google_oauth2/callback'

      assert_response :see_other
    end

    assert_redirected_to home_path
    assert_equal 'ログインしました。', flash[:notice]

    user = User.last

    assert_equal '12345', user.uid
    assert_equal 'Alice', user.name
    assert_equal 'alice@example.com', user.email
  end

  test 'create (After first login)' do
    assert_no_difference 'User.count' do
      get '/auth/google_oauth2/callback'

      assert_response :see_other
    end

    assert_redirected_to home_path
  end

  test 'destroy' do
    get '/auth/google_oauth2/callback'

    delete session_path

    assert_response :see_other
    assert_redirected_to root_path
    assert_equal 'ログアウトしました。', flash[:notice]
  end
end
