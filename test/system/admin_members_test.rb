require 'application_system_test_case'

class AdminMembersTest < ApplicationSystemTestCase
  setup do
    @studio = studios(:wonderland)

    visit root_path

    mock_auth users(:alice) do
      click_on 'Google アカウントでログイン'
    end

    assert_text 'ログインしました。'
  end

  test '設定メニューに土と釉薬が表示されていること' do
    visit studio_settings_path(@studio)

    assert_text '土'
    assert_text '釉薬'
  end

  test 'メンバー一覧が表示されること' do
    visit studio_members_path(@studio)

    assert_text 'Alice'
    assert_text 'Bob'
  end

  test 'admin 権限のメンバーには招待設定、メンバーの権限変更選択欄と削除ボタンが表示されていること' do
    visit studio_members_path(@studio)

    assert_field 'メンバーの招待'
    assert_selector 'select', text: '管理者'
    assert_selector 'button', text: '教室から削除'
  end

  test 'admin 権限のメンバーはメンバーを削除できること' do
    visit studio_members_path(@studio)

    within 'ul.list-group li:nth-child(2)' do
      assert_text 'Bob'
      click_on '教室から削除'
    end

    assert_text 'メンバーを削除しました。'
    assert_text 'Alice'
    assert_no_text 'Bob'
  end
end
