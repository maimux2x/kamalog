require 'test_helper'

class SessionsTest < ActionDispatch::IntegrationTest
  test 'create (First login)' do
    alice = users(:alice)

    Piece.destroy_all
    User.destroy_all

    assert_difference 'User.count', 1 do
      mock_auth alice do
        get '/auth/google_oauth2/callback'
      end

      assert_response :see_other
    end

    assert_redirected_to studios_path
    assert_equal 'ログインしました。', flash[:notice]

    user = User.last

    assert_equal '12345',             user.uid
    assert_equal 'Alice',             user.name
    assert_equal 'alice@example.com', user.email
  end

  test 'create (After first login)' do
    assert_no_difference 'User.count' do
      mock_auth users(:alice) do
        get '/auth/google_oauth2/callback'
      end

      assert_response :see_other
    end

    assert_redirected_to studios_path
  end

  test 'destroy' do
    mock_auth users(:alice) do
      get '/auth/google_oauth2/callback'
    end

    delete session_path

    assert_response :see_other
    assert_redirected_to root_path
    assert_equal 'ログアウトしました。', flash[:notice]
  end
end
