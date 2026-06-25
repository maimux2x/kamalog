require 'application_system_test_case'

class MembersTest < ApplicationSystemTestCase
  setup do
    visit root_path
    sign_in_as users(:alice)

    @studio = users(:alice).studios.first
  end

  test 'メンバー一覧が表示されること' do
    visit studio_members_path(@studio)

    assert_text 'Alice'
    assert_text 'Bob'
  end

  test 'メンバーを削除できること' do
    visit studio_members_path(@studio)

    within 'ul.list-group li:nth-child(2)' do
      click_on '削除'
    end

    assert_text 'メンバーを削除しました。'
    assert_text 'Alice'
    assert_no_text 'Bob'
  end
end
