require 'application_system_test_case'

class My::PiecesJsTest < ApplicationSystemTestCase
  driven_by :selenium, using: :headless_chrome

  setup do
    @studio = studios(:wonderland)

    visit root_path

    mock_auth users(:alice) do
      click_on 'Google で続ける'

      assert_text 'ログインしました。'
    end
  end

  test '製作中の作品を登録する' do
    visit studio_my_pieces_path(@studio)

    click_on '作品を登録'

    fill_in '作品名', with: 'お茶碗'
    select '電動ろくろ', from: '成形方法'

    select '白土',    from: '土'
    fill_in '使用量', with: '0.5'
    choose 'kg', allow_label_click: true

    click_on '釉薬を追加'

    select '白マット', from: '釉薬'

    click_on '登録する'

    assert_text '製作中の作品を登録しました。'
    assert_text 'お茶碗'
    assert_text '製作中'
    assert_text '電動ろくろ'
    assert_text '白土 0.5kg'
    assert_text '白マット'
  end

  test '作品を完成に更新する' do
    visit studio_my_piece_path(@studio, pieces(:cup))

    click_on '編集'

    fill_in '作品名', with: '大きいマグカップ'

    click_on '土を追加'

    within '.kml-piece-form__clays [data-nested-form-target="item"]:nth-last-child(1)' do
      select '黒土',    from: '土'
      fill_in '使用量', with: '100'
      choose 'g', allow_label_click: true
    end

    click_on '釉薬を追加'

    within '.kml-piece-form__glazes [data-nested-form-target="item"]:nth-last-child(1)' do
      select '黒マット', from: '釉薬'
    end

    check 'もう完成している'

    click_on '更新する'

    assert_text '製作中の作品を更新しました。'
    assert_text '大きいマグカップ'
    assert_text '白土 500g'
    assert_text '黒土 100g'
    assert_text '白マット'
    assert_text '黒マット'
  end

  test '作品から土と釉薬を削除する' do
    visit studio_my_piece_path(@studio, pieces(:base))

    click_on '編集'

    within '.kml-piece-form__clays :nth-last-child(1 of [data-nested-form-target="item"])' do
      click_on '削除'
    end

    within '.kml-piece-form__glazes :nth-last-child(1 of [data-nested-form-target="item"])' do
      click_on '削除'
    end

    click_on '更新する'

    assert_text '製作中の作品を更新しました。'
    assert_text '白土'
    assert_no_text '黒土'
    assert_text '白マット'
    assert_no_text '黒マット'
  end
end
