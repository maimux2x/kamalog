require 'application_system_test_case'

class LogsTest < ApplicationSystemTestCase
  setup do
    sign_in_as users(:alice)
  end

  test '作業記録一覧を表示できること' do
    visit my_piece_path(pieces(:cup))

    click_on '作業記録'

    assert_text '2026-04-05'
    assert_text '紐作りでマグカップ作り'
    assert_text '好きな作家さんの作風を参考に作ってみる。'

    assert_text '2026-04-12'
    assert_text '削りで形を整える'
    assert_text '削りを入れて凹凸や底の厚みを削って形を整えた。'
  end

  test '詳細を表示する' do
    visit my_piece_logs_path(pieces(:cup))

    click_on '紐作りでマグカップ作り'

    assert_text '2026-04-05'
    assert_text '紐作りでマグカップ作り'
    assert_text '好きな作家さんの作風を参考に作ってみる。'
  end

  test '作業記録を削除する' do
    visit my_piece_log_path(pieces(:cup), logs(:cup_log_day1))

    click_on '削除'

    assert_text '作業記録を削除しました。'

    assert_no_text '2026-04-05'
    assert_no_text '紐作りでマグカップ作り'
    assert_no_text '好きな作家さんの作風を参考に作ってみる。'

    assert_text '2026-04-12'
    assert_text '削りで形を整える'
    assert_text '削りを入れて凹凸や底の厚みを削って形を整えた。'
  end
end
