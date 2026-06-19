require 'application_system_test_case'

class My::PiecesJsTest < ApplicationSystemTestCase
  driven_by_simulated

  setup do
    visit root_path
    sign_in_as users(:alice)

    @studio = users(:alice).studios.first
  end

  test '製作中の作品を登録する' do
    visit studio_my_pieces_path(@studio)

    click_on '作品を登録'

    fill_in 'タイトル', with: 'お茶碗'
    choose '製作中'
    select '電動ろくろ', from: '成形方法'

    within '[data-nested-form-target="item"]' do
      assert_selector 'button[disabled]', text: '削除'

      select '白土',    from: '土'
      fill_in '使用量', with: '500'
    end

    click_on '釉薬を追加'

    select '白マット', from: '釉薬'

    assert_no_text '作品説明'
    assert_no_text '画像を追加'

    click_on '登録する'

    assert_text '製作中の作品を登録しました。'
    assert_text 'お茶碗'
    assert_text '製作中'
    assert_text '電動ろくろ'
    assert_text '白土 500g'
    assert_text '白マット'
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

  test '作品から土と釉薬を削除する' do
    visit studio_my_piece_path(@studio, pieces(:base))

    click_on '編集'

    within '.clays :nth-last-child(1 of [data-nested-form-target="item"])' do
      click_on '削除'
    end

    within '.glazes :nth-last-child(1 of [data-nested-form-target="item"])' do
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
