require 'application_system_test_case'

class PiecesTest < ApplicationSystemTestCase
  setup do
    sign_in_as users(:alice)
  end

  test 'should create Piece (with one clay, without glaze)' do
    visit my_in_progress_index_path
    assert_selector 'h1', text: '製作中一覧'

    click_on '制作する作品を登録'

    fill_in 'タイトル', with: '花瓶'
    choose '電動ろくろ'
    select '白土',      from: 'Clay'
    fill_in 'Weight',   with: '500'

    click_on '登録する'

    assert_text '製作中の作品を登録しました。'
    assert_text '白土'
    assert_text '500g'
  end

  test 'should create Piece (with one clay and one glaze)' do
    visit my_in_progress_index_path

    click_on '制作する作品を登録'

    fill_in 'タイトル', with: 'お茶碗'
    choose '電動ろくろ'
    select '白土',      from: 'Clay'
    fill_in 'Weight',   with: '500'

    assert_selector 'button[data-nested-form-target="removeButton"][disabled]'

    click_on '釉薬を追加する'

    select '白マット', from: 'Glaze'

    click_on '登録する'

    assert_text '製作中の作品を登録しました。'
    assert_text '白土'
    assert_text '500g'
    assert_text '白マット'
  end

  test 'should edit Piece' do
    visit my_piece_path(pieces(:cup))

    assert_selector 'h1', text: 'マグカップ'

    click_on '編集'

    assert_field 'タイトル', with: 'マグカップ'
    assert_checked_field '紐作り'
    assert_select 'Clay',    selected: '白土'
    assert_select 'Glaze',   selected: '白マット'

    fill_in 'タイトル', with: '大きいマグカップ'

    click_on '更新する'

    assert_text '製作中の作品を更新しました。'
    assert_text '大きいマグカップ'
  end

  test 'should edit Piece (add clay and glaze)' do
    visit my_piece_path(pieces(:cup))

    assert_selector 'h1', text: 'マグカップ'

    click_on '編集'

    click_on '土を追加する'

    within '.clays [data-nested-form-target="item"]:last-child' do
      select '黒土',    from: 'Clay'
      fill_in 'Weight', with: '100'
    end

    click_on '釉薬を追加する'

    within '.glazes [data-nested-form-target="item"]:last-child' do
      select '黒マット', from: 'Glaze'
    end

    click_on '更新する'

    assert_text '製作中の作品を更新しました。'
    assert_text '白土'
    assert_text '500g'
    assert_text '黒土'
    assert_text '100g'
    assert_text '白マット'
    assert_text '黒マット'
  end

  test 'should edit Piece (delete clay and glaze)' do
    visit my_piece_path(pieces(:base))

    assert_selector 'h1', text: '花瓶'

    click_on '編集'

    within all('.clays [data-nested-form-target="item"]').last do
      click_on '削除'
    end

    within all('.glazes [data-nested-form-target="item"]').last do
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
