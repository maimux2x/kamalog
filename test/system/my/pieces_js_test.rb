require 'application_system_test_case'

class My::PiecesJsTest < ApplicationSystemTestCase
  driven_by_selenium

  setup do
    sign_in_as users(:alice)

    @studio = users(:alice).studios.first
  end

  test '作品を完成に更新する' do
    visit studio_my_piece_path(@studio, pieces(:cup))

    click_on '編集'

    fill_in 'タイトル', with: '大きいマグカップ'

    choose '完成'

    click_on '土を追加'

    within '.clays :nth-last-child(1 of [data-nested-form-target="item"])' do
      select '黒土',    from: '土'
      fill_in '使用量', with: '100'
    end

    click_on '釉薬を追加'

    within '.glazes :nth-last-child(1 of [data-nested-form-target="item"])' do
      select '黒マット', from: '釉薬'
    end

    fill_in '作品説明', with: 'たくさん量が入るマグカップを作った'

    attach_file file_fixture('dish_cup.png'), make_visible: true

    fill_in '説明', with: '持ち手を工夫した'

    click_on '更新する'

    assert_text '製作中の作品を更新しました。'
    assert_text '大きいマグカップ'
    assert_text '白土 500g'
    assert_text '黒土 100g'
    assert_text '白マット'
    assert_text '黒マット'
    assert_text 'たくさん量が入るマグカップを作った'
    assert_selector 'img[src$="/dish_cup.png"]'
    assert_text '持ち手を工夫した'
  end
end
