require 'application_system_test_case'

class MemberMembersTest < ApplicationSystemTestCase
  setup do
    visit root_path
    sign_in_as users(:bob)

    @studio = studios(:wonderland)
  end

  test 'member 権限のメンバーには自分自身にだけ教室からの退出ボタンが表示されること' do
    visit studio_members_path(@studio)

    within 'ul.list-group li:nth-child(1)' do
      assert_no_text '退出'
    end

    within 'ul.list-group li:nth-child(2)' do
      assert_text '退出'
    end
  end

  test 'member 権限のメンバーには招待設定、メンバーの権限変更選択欄と削除ボタンが表示されないこと' do
    visit studio_members_path(@studio)

    assert_no_field 'メンバーの招待'
    assert_no_selector 'select', text: '管理者'
    assert_no_selector 'button', text: '教室から削除'
  end
end
