require 'application_system_test_case'

class GlazesJSTest < ApplicationSystemTestCase
  driven_by_simulated

  setup do
    visit root_path

    mock_auth users(:alice) do
      click_on 'Google アカウントでログイン'
    end

    assert_text 'ログインしました。'

    @studio = studios(:wonderland)
  end

  test '釉薬の表示順の並び替えができること' do
    visit studio_glazes_path(@studio)

    source = find('ul.list-group li:nth-child(3) .handle')
    target = find('ul.list-group li:nth-child(2)')

    source.drag_to target

    within 'ul.list-group li:nth-child(1)' do
      assert_text '白マット'
    end

    within 'ul.list-group li:nth-child(2)' do
      assert_text 'パールラスター'
    end

    within 'ul.list-group li:nth-child(3)' do
      assert_text '黒マット'
    end
  end
end
