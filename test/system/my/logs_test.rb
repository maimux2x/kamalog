require 'application_system_test_case'

class My::LogsTest < ApplicationSystemTestCase
  setup do
    @studio = studios(:wonderland)
    @piece  = pieces(:cup)

    visit root_path

    mock_auth users(:alice) do
      click_on 'Google で続ける'
    end

    assert_text 'ログインしました。'
  end

  test '作業記録を表示できること' do
    visit studio_my_piece_path(@studio, @piece)

    assert_text '2026-04-05'
    assert_text '好きな作家さんの作風を参考に作ってみる。'

    assert_text '2026-04-12'
    assert_text '削りを入れて凹凸や底の厚みを削って形を整えた。'
  end

  test '作業記録を削除する' do
    visit studio_my_piece_log_path(@studio, @piece, logs(:cup_log_day1))

    click_on '削除'

    assert_text '作業記録を削除しました。'

    assert_no_text '2026-04-05'
    assert_no_text '好きな作家さんの作風を参考に作ってみる。'

    assert_text '2026-04-12'
    assert_text '削りを入れて凹凸や底の厚みを削って形を整えた。'
  end
end
