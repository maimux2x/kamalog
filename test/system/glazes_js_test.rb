require 'application_system_test_case'

class GlazesJSTest < ApplicationSystemTestCase
  driven_by_simulated

  setup do
    visit root_path
    sign_in_as users(:alice)

    @studio = studios(:wonderland)
  end

  test '釉薬の表示順の並び替えができること' do
    visit studio_glazes_path(@studio)

    within 'ul.list-group li:nth-child(3)' do
      select 2, from: 'glaze[position]'
    end

    assert_text '釉薬を更新しました。'

    within 'ul.list-group li:nth-child(1)' do
      assert_text '白マット'
      assert_select 'glaze[position]', selected: '1'
    end

    within 'ul.list-group li:nth-child(2)' do
      assert_text 'パールラスター'
      assert_select 'glaze[position]', selected: '2'
    end

    within 'ul.list-group li:nth-child(3)' do
      assert_text '黒マット'
      assert_select 'glaze[position]', selected: '3'
    end
  end
end
