require 'application_system_test_case'

class InvitationsTest < ApplicationSystemTestCase
  setup do
    @studio = studios(:wonderland)
  end

  test '未ログインかつアカウントが未作成' do
    visit invitation_path(@studio.token)

    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid:      'UID',

      info: {
        name:  'lisa',
        email: 'lisa@example.com'
      }
    )

    click_on 'Google アカウントでログイン'

    assert_text 'ログインしました。'

    click_on '参加する'

    assert_text 'ワンダーランド教室に参加しました。'
  end

  test '未ログインかつアカウント作成済み教室へ未参加' do
    visit invitation_path(@studio.token)

    sign_in_as users(:ben)

    assert_text 'ログインしました。'

    click_on '参加する'

    assert_text 'ワンダーランド教室に参加しました。'
  end

  test '未ログインかつアカウント作成済み教室へ参加済み' do
    visit invitation_path(@studio.token)

    sign_in_as users(:alice)

    assert_text 'ログインしました。'
    assert_text 'すでに参加済みです。'

    click_on '教室へ移動'

    assert_current_path studio_path(@studio)
  end

  test '招待が無効の場合、教室が見つからないこと' do
    @studio.update! invitation_enabled: false

    visit invitation_path(@studio.token)

    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid:      'UID',

      info: {
        name:  'lisa',
        email: 'lisa@example.com'
      }
    )

    click_on 'Google アカウントでログイン'

    assert_text "The page you were looking for doesn't exist"
  end
end
