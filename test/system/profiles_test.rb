require 'application_system_test_case'

class ProfilesTest < ApplicationSystemTestCase
  setup do
    visit root_path
    sign_in_as users(:alice)
  end

  test 'ユーザー名を更新できること' do
    visit profile_path

    fill_in '名前', with: 'ありす'

    click_on '更新する'

    assert_selector 'input[value="ありす"]'
  end

  test 'サービスを退会できること' do
    visit profile_path

    assert_difference('User.count', -1) do
      click_on '退会'
    end

    assert_text 'アカウントを削除しました。'
    assert_text 'ログイン'
  end
end
