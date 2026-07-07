require 'application_system_test_case'

class AdminMembersTest < ApplicationSystemTestCase
  setup do
    visit root_path
    sign_in_as users(:alice)

    @studio = memberships(:alice_membership).studio
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
      click_on '教室から削除'
    end

    assert_text 'メンバーを削除しました。'
    assert_text 'Alice'
    assert_no_text 'Bob'
  end
end
