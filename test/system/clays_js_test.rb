require 'application_system_test_case'

class ClaysJsTest < ApplicationSystemTestCase
  driven_by_simulated

  setup do
    @studio = studios(:wonderland)

    visit root_path

    mock_auth users(:alice) do
      click_on 'Google アカウントでログイン'
    end

    assert_text 'ログインしました。'
  end

  test '土の表示順を並び替えできること（白→黒→赤から白→赤→黒）' do
    visit studio_clays_path(@studio)

    source = find('ul.list-group li:nth-child(2) .handle')
    target = find('ul.list-group li:nth-child(3)')

    source.drag_to target

    within 'ul.list-group li:nth-child(1)' do
      assert_text '白土'
    end

    within 'ul.list-group li:nth-child(2)' do
      assert_text '赤土'
    end

    within 'ul.list-group li:nth-child(3)' do
      assert_text '黒土'
    end
  end
end
