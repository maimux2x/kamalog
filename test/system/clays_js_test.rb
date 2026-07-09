require 'application_system_test_case'

class ClaysJsTest < ApplicationSystemTestCase
  driven_by_simulated

  setup do
    visit root_path
    sign_in_as users(:alice)

    @studio = users(:alice).memberships.first.studio
  end

  test '土の表示順を並び替えできること（白→黒→赤から白→赤→黒）' do
    visit studio_clays_path(@studio)

    within 'ul.list-group li:nth-child(2)' do
      select 3, from: 'clay[position]'
    end

    assert_text '土を更新しました。'

    within 'ul.list-group li:nth-child(1)' do
      assert_text '白土'
      assert_select 'clay[position]', selected: '1'
    end

    within 'ul.list-group li:nth-child(2)' do
      assert_text '赤土'
      assert_select 'clay[position]', selected: '2'
    end

    within 'ul.list-group li:nth-child(3)' do
      assert_text '黒土'
      assert_select 'clay[position]', selected: '3'
    end
  end
end
