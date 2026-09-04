require 'test_helper'

class MemberTest < ActionDispatch::IntegrationTest
  setup do
    @membership = memberships(:bob_membership)
    @studio     = @membership.studio

    mock_auth users(:bob) do
      get '/auth/google_oauth2/callback'
    end
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
