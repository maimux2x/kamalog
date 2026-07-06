require 'test_helper'

class AdminTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid:      '12345',

      info: {
        name:  'Alice',
        email: 'alice@example.com'
      }
    )

    get '/auth/google_oauth2/callback'

    @membership = memberships(:alice_membership)
    @studio = studios(:wonderland)
  end

  teardown do
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end

  test 'last admin cannot leave (update)' do
    patch studio_member_path(@studio, @membership), params: {
      role: :member
    }

    assert_redirected_to studio_members_path(@studio)
    assert_equal '管理者は最低一人必要です。', flash[:alert]
  end

  test 'last admin cannot leave (destroy)' do
    delete studio_member_path(@studio, @membership)

    assert_redirected_to studio_members_path(@studio)
    assert_equal '管理者は最低一人必要です。', flash[:alert]
  end
end
