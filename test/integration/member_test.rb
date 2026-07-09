require 'test_helper'

class MemberTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid:      '67890',

      info: {
        name:  'Bob',
        email: 'bob@example.com'
      }
    )

    get '/auth/google_oauth2/callback'

    @membership = memberships(:bob_membership)
    @studio     = @membership.studio
  end

  teardown do
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end

  test 'メンバーは権限を更新できないこと' do
    patch studio_member_path(@studio, memberships(:alice_membership)), params: {
      role: :member
    }

    assert_redirected_to studio_members_path(@studio)
    assert_equal '権限がありません。', flash[:alert]
  end

  test 'メンバーは他のメンバーを教室から削除できないこと' do
    delete studio_member_path(@studio, memberships(:alice_membership))

    assert_redirected_to studio_members_path(@studio)
    assert_equal '権限がありません。', flash[:alert]
  end
end
