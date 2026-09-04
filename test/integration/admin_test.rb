require 'test_helper'

class AdminTest < ActionDispatch::IntegrationTest
  setup do
    @membership = memberships(:alice_membership)
    @studio     = studios(:wonderland)

    mock_auth users(:alice) do
      get '/auth/google_oauth2/callback'
    end
  end

  test '最後の管理者は自分自身の権限をメンバーに更新できないこと(update)' do
    patch studio_member_path(@studio, @membership), params: {
      role: :member
    }

    assert_redirected_to studio_members_path(@studio)
    assert_equal '管理者は最低一人必要です。', flash[:alert]
  end

  test '最後の管理者は自分自身を教室から削除できないこと(destroy)' do
    delete studio_member_path(@studio, @membership)

    assert_redirected_to studio_members_path(@studio)
    assert_equal '管理者は最低一人必要です。', flash[:alert]
  end
end
