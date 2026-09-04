require 'application_system_test_case'

class InvitationsTest < ApplicationSystemTestCase
  setup do
    @studio = studios(:wonderland)
  end

  test '未ログインかつアカウントが未作成' do
    visit invitation_path(@studio.invitation_token)

    mock_auth User.new(uid: 42, name: 'lisa', email: 'lisa@example.com') do
      click_on 'Google アカウントでログイン'
    end

    assert_text 'ログインしました。'

    click_on '参加する'

    assert_text 'ワンダーランド教室に参加しました。'
  end

  test '未ログインかつアカウント作成済み教室へ未参加' do
    visit invitation_path(@studio.invitation_token)

    mock_auth users(:ben) do
      click_on 'Google アカウントでログイン'
    end

    assert_text 'ログインしました。'

    click_on '参加する'

    assert_text 'ワンダーランド教室に参加しました。'
  end

  test '未ログインかつアカウント作成済み教室へ参加済み' do
    visit invitation_path(@studio.invitation_token)

    mock_auth users(:alice) do
      click_on 'Google アカウントでログイン'
    end

    assert_text 'ログインしました。'
    assert_text 'すでに参加済みです。'

    click_on '教室へ移動'

    assert_current_path studio_path(@studio)
  end
end
