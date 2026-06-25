require 'application_system_test_case'

class GlazesTest < ApplicationSystemTestCase
  setup do
    visit root_path
    sign_in_as users(:alice)

    @studio = users(:alice).memberships.first.studio
  end

  test '釉薬の一覧が表示できること' do
    visit studio_glazes_path(@studio)

    assert_text '白マット'
    assert_text '黒マット'
  end

  test '釉薬の新規登録ができること' do
    visit new_studio_glaze_path(@studio)

    fill_in '名前', with: '透明釉'
    click_on '登録する'

    assert_text '釉薬を登録しました。'
    assert_text '白マット'
    assert_text '透明釉'
  end

  test '同じ名前の釉薬は登録できないこと' do
    visit new_studio_glaze_path(@studio)

    fill_in '名前', with: '白マット'
    click_on '登録する'

    assert_text 'はすでに存在します'
  end

  test '釉薬を更新できること' do
    visit edit_studio_glaze_path(@studio, glazes(:white_matte))

    fill_in '名前', with: '白マット（薄め）'
    click_on '更新する'

    assert_text '釉薬を更新しました。'
    assert_text '白マット（薄め）'
  end

  test '作品で使われている釉薬は削除できないこと' do
    visit studio_glazes_path(@studio)

    within 'ul.list-group li:first-child' do
      click_on '削除'
    end

    assert_text 'すでに作品で使用されているため削除できません。'
    assert_text '白マット'
    assert_text '黒マット'
  end

  test '作品で使われていない釉薬は削除できること' do
    visit studio_glazes_path(@studio)

    within 'ul.list-group li:nth-child(3)' do
      click_on '削除'
    end

    assert_text    '釉薬を削除しました。'
    assert_text    '白マット'
    assert_no_text 'パールラスター'
  end
end
